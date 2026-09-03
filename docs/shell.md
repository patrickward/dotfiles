# Shell helpers
<!-- zref: Information on using shell helpers on this computer -->

This repo has three places for shell helpers. Use the smallest thing that fits.

## Topic `.zsh` files

Example:

    topics/caddy/caddy.zsh

Use a topic `.zsh` file for shell config that belongs to one tool or topic:

- environment variables
- aliases
- small related functions
- tool initialization

These files are sourced during interactive shell startup, so everything in them is loaded
immediately.

Good examples:

    CADDYFILE
    CADDY_SITES_DIR
    caddy-site
    caddy-reload

Rule of thumb: if the helper only makes sense because a topic exists, keep it with that
topic.

## `zsh/functions/`

Example:

    zsh/functions/port-find

Use `zsh/functions/` for standalone interactive shell functions.

These should feel like small commands, not like configuration for one topic. They are
autoloaded by zsh, so they do not need to be sourced at shell startup.

Good examples:

    port-find
    mkcd
    extract

Rule of thumb: if the helper is useful across topics and only needs an interactive zsh
shell, put it in `zsh/functions/`.

## `bin/`

Example:

    bin/flush-dns

Use `bin/` for executable scripts that should work outside an interactive shell.

These can be called from:

- zsh
- bash
- other scripts
- automation
- cron or launchd

Good examples:

    zdot
    flush-dns

Rule of thumb: if it should behave like a real command and not depend on interactive zsh
startup, put it in `bin/`.

## Quick decision guide

Use a topic `.zsh` file when:

    "This is shell integration for one topic."

Use `zsh/functions/` when:

    "This is a reusable interactive zsh helper."

Use `bin/` when:

    "This should be executable as a real script."
