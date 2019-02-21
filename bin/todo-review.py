#!/usr/bin/env python

"""
Pull completed and upcoming tasks from todo.txt for review.

Use the config.cfg file to set api keys and/or tokens.

"""

import os
import sys
import click
from datetime import date, timedelta
from configparser import ConfigParser, NoSectionError
from postmarker.core import PostmarkClient
from pathlib import Path
from pylibs import todotxt
from ast import literal_eval


@click.command()
@click.option('--task_filter', default=None, help='The filter to apply on the tasks list')
@click.option('--action', default=None, help='A built-in action filter')
@click.option('--message', default=None, help='Path to a message file that will be included in the morning email.')
@click.option('--preview/--no-preview', default=True, help='Send to the preview recipient or not.')
@click.option('--completed_since', default=None, help='Show tasks completed after this date, use YYYY-MM-DD format.')
@click.option('--project', default='Work', help='The project to filter against')
def main(task_filter, action, message, preview, completed_since, project):

    try:

        config_file = os.getenv('XDG_CONFIG_HOME', '%s/.config' % os.getenv('HOME'))
        config_file = '%s/pw' % config_file
        config = ConfigParser()
        config.read('%s/todo-review.cfg' % config_file)

        todo_file = os.getenv('TODO_FILE')
        done_file = os.getenv('DONE_FILE')

        postmark = PostmarkClient(server_token=config.get('postmark', 'server_token'),
                                  account_token=config.get('postmark', 'account_token'))

        options = {
            'template_id': config.get('postmark', 'template_id'),
            'from': config.get('postmark', 'from'),
            'to': config.get('postmark', 'to'),
            'to_preview': config.get('postmark', 'to_preview'),
            'cc': config.get('postmark', 'cc'),
            'message': message,
            'completed_since': completed_since,
            'project': project,
            'preview': preview,
            'use_html': not preview
        }

        review = Review(todo_file, done_file, postmark, options)

        def echo(x):
            if type(x) is list:
                click.echo(click.style('\n'.join(x), fg='cyan'))
            else:
                click.echo(click.style(x, fg='cyan'))

        if action is not None:
            results = getattr(review, action)()
        elif task_filter is not None:
            args = literal_eval(task_filter)
            results = review.get_task_list(review.incomplete_todos, args)
        else:
            click.echo(click.style('Filter not found, choose an action or a filter', bold=True, fg='red'))
            sys.exit(1)

    except AttributeError as e:
        print(e)
        click.echo(click.style("Action not found: %s" % action, bold=True, fg='red'))
    except NoSectionError as e:
        click.echo(click.style("Config section not found; check the config.cfg file. %s" % e, bold=True, fg='red'))


class Review:

    def __init__(self, todo_file, done_file, postmark, options):
        self.todo_file = todo_file
        self.done_file = done_file
        self.postmark = postmark
        self.options = options
        self.incomplete_todos = todotxt.from_file(todo_file)
        self.completed_todos = todotxt.from_file(done_file)
        self.review_date = date.today().strftime('%m/%d/%Y')
        self.today = date.today().strftime('%Y-%m-%d')
        self.yesterday = (date.today() - timedelta(1)).strftime('%Y-%m-%d')
        self.tomorrow = (date.today() + timedelta(1)).strftime('%Y-%m-%d')

    def completed_yesterday(self):

        return self.get_task_list(self.completed_todos, {
            'completion_date': self.yesterday,
            'projects': [self.options['project']]
        }, sort_by_priority=False)

    def scheduled(self):
        return self.get_task_list(self.incomplete_todos, {
            'or': {
                'contexts': ['next'],
                'overdue': True
            },
            'not_contexts': ['assigned'],
            'projects': [self.options['project']]
        })

    def assigned(self):
        return self.get_task_list(self.incomplete_todos, {
            'contexts': ['assigned'],
            'projects': [self.options['project']]
        })

    def next(self):
        return self.get_task_list(self.incomplete_todos, {
            'or': {
                'due_after': self.today,
                'not_contexts': ['next']
            },
            'not_contexts': ['assigned'],
            'projects': [self.options['project']]
        })

    def morning_review(self, project='Work'):
        self.options['project'] = project
        self.options['use_html'] = False
        return '\n'.join([
            '\n### Completed Yesterday ###\n',
            '\n'.join(self.completed_yesterday()),
            '\n### Assigned ###\n',
            '\n'.join(self.assigned()),
            '\n### Scheduled Today ###\n',
            '\n'.join(self.scheduled()),
            '\n### Next on the Horizon ###\n',
            '\n'.join(self.next()),
        ])

    def email_review(self, project='Work'):

        self.options['use_html'] = True
        self.options['project'] = project
        completed_since = self.options['completed_since']

        if completed_since is None:
            completed_message = 'yesterday'
            completed_tasks = self.completed_yesterday()
        else:
            completed_message = 'since Friday'
            completed_tasks = self.get_task_list(
                    self.completed_todos, {
                        'completion_date': completed_since,
                        'projects': ['Work']}, True)

        assigned_tasks = self.assigned()
        scheduled_tasks = self.scheduled()
        next_tasks = self.next()

        try:
            if self.options['message'] is None:
                raise FileNotFoundError
            message_file = Path(self.options['message'])
            message_file = message_file.resolve(strict=True)
        except FileNotFoundError:
            message = "Here is today's morning review..."
        else:
            message_file = open(message_file, 'r')
            message = message_file.read()

        if self.options['preview']:
            email_to = self.options['to_preview']
            email_cc = ''
        else:
            email_to = self.options['to']
            email_cc = self.options['cc']

        self.postmark.emails.send_with_template(
            TemplateId=self.options['template_id'],
            TemplateModel={
                'completed_message': completed_message,
                'completed_tasks': completed_tasks,
                'assigned_tasks': assigned_tasks,
                'scheduled_tasks': scheduled_tasks,
                'next_tasks': next_tasks,
                'message': message,
                'review_date': self.review_date
            },
            From=self.options['from'],
            To=email_to,
            Cc=email_cc
        )

    def sort_by_priority(self, priority):
        if priority is None:
            return '(A)'
        else:
            return priority

    def get_task_list(self, todo_list, task_filter, sort_by_priority=True):
        """Get tasks from todo.txt and print them"""
        results = todotxt.search(todo_list, **task_filter)
        # results = sorted(results, key=lambda x: x.priority)
        if sort_by_priority:
            results = sorted(results, key=lambda x: self.sort_by_priority(x.priority))
        tasks = list()
        for task in results:
            task_text = task.text
            context_list = ['@%s' % context for context in task.contexts]
            contexts = ' %s' % ', '.join(context_list)
            tag_list = ['%s: %s' % (tag, task.tags[tag]) for tag in task.tags]
            tags = ' %s' % ', '.join(tag_list)
            if self.options['use_html']:
                contexts_span = ''
                if context_list:
                    contexts_span = '<li>Contexts: <span class="contexts">%s</span></li>' % contexts
                tags_span = ''
                if tag_list:
                    tags_span = '<li>Tags: <span class="tags">%s</span></li>' % tags

                tags_and_contexts = ''
                if contexts_span or tags_span:
                    tags_and_contexts = '<ul class="task_attributes">%s%s</ul>' % (contexts_span, tags_span)
                if task.priority == 'A':
                    tasks.append({'task': '<span class="priority-1">%s</span>%s' % (task_text, tags_and_contexts)})
                elif task.priority == 'B':
                    tasks.append({'task': '<span class="priority-2">%s</span>%s' % (task_text, tags_and_contexts)})
                elif task.priority == 'C':
                    tasks.append({'task': '<span class="priority-3">%s</span>%s' % (task_text, tags_and_contexts)})
                else:
                    tasks.append({'task': '%s %s' % (task_text, tags_and_contexts)})
            else:
                tasks.append('* %s [contexts: %s] {tags: %s}' % (task_text, ', '.join(context_list), ', '.join(tag_list)))

        sys.exit
        return tasks


if __name__ == '__main__':
    main()

