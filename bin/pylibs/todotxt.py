# Original from: https://github.com/EpocDotFr/todotxtio
#
# With modifications by me (Patrick Ward)
#
import os
import re
from datetime import datetime, date

__version__ = '0.2.3'

__all__ = [
    'from_dicts',
    'from_stream',
    'from_file',
    'from_string',
    'to_dicts',
    'to_stream',
    'to_file',
    'to_string',
    'Todo',
    'search'
]

todo_data_regex = re.compile(r'^(?:(x) )?(?:(\d{4}-\d{2}-\d{2}) )?(?:\(([A-Z])\) )?(?:(\d{4}-\d{2}-\d{2}) )?')
todo_project_regex = re.compile(r' \+(\S+)')
todo_context_regex = re.compile(r' @(\S+)')
todo_tag_regex = re.compile(r' (\S+):([^\s/]+)')


def from_dicts(todos):
    """Convert a list of todo dicts to a list of :class:`todotxtio.Todo` objects.

    :param list todos: A list of todo dicts
    :rtype: list
    """
    return [Todo(**todo) for todo in todos]


def from_stream(stream, close=True):
    """Load a todo list from an already-opened stream.

    :param file stream: A file-like object
    :param bool close: Whetever to close the stream or not after all operation are finised
    :rtype: list
    """
    string = stream.read()

    if close:
        stream.close()

    return from_string(string)


def from_file(file_path, encoding='utf-8'):
    """Load a todo list from a file.

    :param str file_path: Path to the file
    :param str encoding: The encoding of the file to open
    :rtype: list
    """
    if not os.path.isfile(file_path):
        raise FileNotFoundError('File doesn\'t exists: ' + file_path)

    stream = open(file_path, 'r', encoding=encoding)

    return from_stream(stream)


def from_string(string):
    """Load a todo list from a string.

    :param str string: The string to parse
    :rtype: list
    """
    todos = []

    for line in string.strip().splitlines():
        line = line.strip()

        todo_pre_data = todo_data_regex.match(line)

        todo = Todo()

        if todo_pre_data:
            todo.completed = todo_pre_data.group(1) == 'x'

            if todo.completed:
                todo.creation_date = todo_pre_data.group(4)

                if todo_pre_data.group(2):
                    todo.completion_date = todo_pre_data.group(2)
            else:
                todo.creation_date = todo_pre_data.group(2)

            todo.priority = todo_pre_data.group(3)

            text = todo_data_regex.sub('', line).strip()
        else:
            text = line

        todo_projects = todo_project_regex.findall(text)

        if len(todo_projects) > 0:
            todo.projects = todo_projects
            text = todo_project_regex.sub('', text).strip()

        todo_contexts = todo_context_regex.findall(text)

        if len(todo_contexts) > 0:
            todo.contexts = todo_contexts
            text = todo_context_regex.sub('', text).strip()

        todo_tags = todo_tag_regex.findall(text)

        if len(todo_tags) > 0:
            for todo_tag in todo_tags:
                todo.tags[todo_tag[0]] = todo_tag[1]

            text = todo_tag_regex.sub('', text).strip()

        todo.text = text

        todos.append(todo)

    return todos


def to_dicts(todos):
    """Convert a list of :class:`todotxtio.Todo` objects to a list of todo dict.

    :param list todos: List of :class:`todotxtio.Todo` objects
    :rtype: list
    """
    return [todo.to_dict() for todo in todos]


def to_stream(stream, todos, close=True):
    """Write a list of todos to an already-opened stream.

    :param file stream: A file-like object
    :param list todos: List of :class:`todotxtio.Todo` objects
    :param bool close: Whetever to close the stream or not after all operation are finised
    :rtype: None
    """
    stream.write(to_string(todos))

    if close:
        stream.close()


def to_file(file_path, todos, encoding='utf-8'):
    """Write a list of todos to a file.

    :param str file_path: Path to the file
    :param list todos: List of :class:`todotxtio.Todo` objects
    :param str encoding: The encoding of the file to open
    :rtype: None
    """
    stream = open(file_path, 'w', encoding=encoding)
    to_stream(stream, todos)


def to_string(todos):
    """Convert a list of todos to a string.

    :param list todos: List of :class:`todotxtio.Todo` objects
    :rtype: str
    """
    return '\n'.join([str(todo) for todo in todos])


class Todo:
    """Represent one todo.

    :param str text: The text of the todo
    :param bool completed: Should this todo be marked as completed?
    :param str completion_date: A date of completion, in the ``YYYY-MM-DD`` format.
               Setting this property will automatically set the ``completed`` attribute to ``True``.
    :param str priority: The priority of the todo represented by a char between ``A-Z``
    :param str creation_date: A date of creation, in the ``YYYY-MM-DD`` format
    :param list projects: A list of projects without leading ``+``
    :param list contexts: A list of projects without leading ``@``
    :param dict tags: A dict of tags
    """
    text = None
    completed = False
    completion_date = None
    priority = None
    creation_date = None
    projects = []
    contexts = []
    tags = {}

    def __init__(self, text=None, completed=False, completion_date=None,
                 priority=None, creation_date=None,
                 projects=None, contexts=None, tags=None):
        self.text = text
        self.completed = completed

        if completion_date and self.completed:
            self.completion_date = completion_date

        self.priority = priority
        self.creation_date = creation_date
        self.projects = projects
        self.contexts = contexts
        self.tags = tags

    def to_dict(self):
        """Return a dict representation of this Todo instance.

        :rtype: dict
        """
        return {
            'text': self.text,
            'completed': self.completed,
            'completion_date': self.completion_date,
            'priority': self.priority,
            'creation_date': self.creation_date,
            'projects': self.projects,
            'contexts': self.contexts,
            'tags': self.tags,
        }

    def __setattr__(self, name, value):
        if name == 'completed':
            if not value:
                # Uncompleted todo must not have any completion date
                super().__setattr__('completion_date', None)
        elif name == 'completion_date':
            if value:
                # Setting the completion date must set this todo as completed...
                super().__setattr__('completed', True)
            else:
                # ...and vice-versa
                super().__setattr__('completed', False)
        elif name in ['projects', 'contexts']:
            if not value:
                # Force contexts, projects to be lists when setting them to a falsely value
                super().__setattr__(name, [])
                return
            elif type(value) is not list:
                # Make sure, otherwise, that the provided value is a list
                raise ValueError(name + ' should be a list')
        elif name == 'tags':
            if not value:
                # Force tags to be a dict when setting them to a falsely value
                super().__setattr__(name, {})
                return
            elif type(value) is not dict:
                # Make sure, otherwise, that the provided value is a dict
                raise ValueError(name + ' should be a dict')

        super().__setattr__(name, value)

    def __str__(self):
        """Convert this Todo object in a valid Todo.txt line."""
        ret = []

        if self.completed:
            ret.append('x')

        if self.completion_date:
            ret.append(self.completion_date)

        if self.priority:
            ret.append('(' + self.priority + ')')

        if self.creation_date:
            ret.append(self.creation_date)

        ret.append(self.text)

        if self.projects:
            ret.append(''.join([' +' + project for project in self.projects]).strip())

        if self.contexts:
            ret.append(''.join([' @' + context for context in self.contexts]).strip())

        if self.tags:
            ret.append(''.join([' ' + tag_name + ':' + tag_value for tag_name, tag_value in self.tags.items()]).strip())

        return ' '.join(ret)

    def __repr__(self):
        """Call the __str__ method to return a textual representation of this Todo object."""
        return self.__str__()


def search_todo(todo, key, value):

        if key in ['text', 'priority']:
            return value in getattr(todo, key)

        elif key in ['completed', 'completion_date', 'creation_date']:
            return value == getattr(todo, key)

        elif key in ['contexts', 'projects']:
            return any(i in value for i in getattr(todo, key))

        elif key in ['not_contexts', 'not_projects']:
            key = key[4:]
            return not any(i in value for i in getattr(todo, key))

        elif key in ['tags']:
            attr = getattr(todo, key)
            return any(attr[k] == v for k, v in value.items() if k in attr)

        elif key in ['completed_since']:
            completed_date = datetime.strptime(todo.completion_date, '%Y-%m-%d')
            completed_date_search = datetime.strptime(value, '%Y-%m-%d')
            return completed_date >= completed_date_search

        elif key in ['due_after']:
            if 'due' in todo.tags:
                due = datetime.strptime(todo.tags['due'], '%Y-%m-%d')
                due_search = datetime.strptime(value, '%Y-%m-%d')
                return due > due_search
            return False

        elif key in ['overdue']:
            if 'due' in todo.tags:
                due = datetime.strptime(todo.tags['due'], '%Y-%m-%d').date()
                today = date.today()
                return due < today

        return False


def search(todos, **kwargs):

    """Return a list of todos that matches the provided filters.

    It takes the exact same parameters as the :class:`todotxtio.
    Todo` object constructor, and return a list of :class:`todotxtio.Todo` objects as well.
    All criteria defaults to ``None`` which means that the criteria is ignored.

    A todo will be returned in the results list if all of the criteria matches.
    From the moment when a todo is sent in the results list, it will
    never be checked again.

    :param list todos: List of todos to test
    :param dict kwargs: Dictionary of tests
    :rtype: list
    """
    results = []

    for todo in todos:

        matches = []
        for key, value in kwargs.items():

            if key == 'or':

                or_matches = []
                for k, v in value.items():
                    or_matches += [search_todo(todo, k, v)]

                matches.append(any(match is True for match in or_matches))

            else:
                matches += [search_todo(todo, key, value)]

        if matches and all(match is True for match in matches):
            results.append(todo)

    return results
