# Zsh startup file reference

## Shell types

Zsh distinguishes between shell types, and which startup files it loads depends on which types apply to the current invocation. Types are not mutually exclusive.

| Type                        | When                           | Examples                            |
|-----------------------------|--------------------------------|-------------------------------------|
| **login**                   | First shell of a session       | Terminal.app open, `ssh` in, `su -` |
| **interactive**             | Has a prompt, reads user input | Any shell you type into             |
| **non-interactive**         | Runs a script, no prompt       | `zsh script.sh`, CI, cron           |
| **login + interactive**     | Most common case               | Opening a new terminal tab          |
| **login + non-interactive** | Rare                           | `ssh host command` (some configs)   |

You can test the current shell's type:
```zsh
[[ -o login ]]       && echo "login"
[[ -o interactive ]] && echo "interactive"
```

---

## Load order

```
Every zsh invocation:
  ~/.zshenv

Login shells only (before zshrc):
  ~/.zprofile

Interactive shells only:
  ~/.zshrc

Login shells only (after zshrc):
  ~/.zlogin

Login shells, on exit:
  ~/.zlogout
```

Full sequence for a login interactive shell (the common case):

```
zshenv → zprofile → zshrc → zlogin
                                   (session runs)
                          zlogout ←
```

---

## What each file is for

### `zshenv` → `~/.zshenv`
Loaded for **every** zsh invocation: interactive, non-interactive, login, scripts, and subshells.

**Use for:** environment variables that must be present everywhere — `DOTFILES`, `XDG_*`, `PATH`, `ZDOTDIR`.

**Avoid:** output, aliases, functions, anything slow. This runs for every `zsh script.sh` call.

---

### `zprofile` → `~/.zprofile`
Loaded for **login shells only**, before `zshrc`.

The login-shell equivalent of `.bash_profile`. Run once when you open a terminal or SSH in.

**Use for:** environment variables that only matter for interactive sessions — `EDITOR`, `VISUAL`, `PAGER`, `LANG`, `LESS`. Also: anything that should run once at login (SSH agent startup, etc.).

**Avoid:** aliases, functions, completion setup (those belong in `zshrc`).

> Note: `PATH` and Homebrew are set in `zshenv`/`path.zsh` here so they're available to scripts too, not just login shells.

---

### `zshrc` → `~/.zshrc`
Loaded for **interactive shells only** (login or not).

This is the main configuration file. Runs every time you open a terminal tab.

**Use for:** prompt, aliases, functions, key bindings, completion (`compinit`), plugins, topic files.

**Avoid:** expensive one-time setup that doesn't need to repeat per tab (put that in `zprofile` or `zlogin`).

---

### `zlogin` → `~/.zlogin`
Loaded for **login shells only**, after `zshrc`.

Historically used by csh-style setups. In zsh it's a good place for post-login tasks that depend on the interactive config being fully loaded.

**Use for:** compiling the completion dump (`.zcompdump → .zcompdump.zwc`), starting background agents that need aliases or functions from `zshrc`.

**Avoid:** environment variables (too late — subshells won't inherit them from here).

---

### `zlogout` → `~/.zlogout`
Loaded when a **login shell exits**.

**Use for:** cleanup — stopping agents, clearing sensitive env vars, logging session end.

**Avoid:** anything that assumes an interactive terminal (it may already be gone).

---

## Decision guide: where does X go?

| What you're setting               | File                                                |
|-----------------------------------|-----------------------------------------------------|
| `$PATH`, `$DOTFILES`, `$XDG_*`    | `zshenv`                                            |
| `$EDITOR`, `$LANG`, `$LESS`       | `zprofile`                                          |
| Aliases, functions                | `zshrc`                                             |
| Prompt, key bindings              | `zshrc`                                             |
| Completion (`compinit`, `zstyle`) | `zshrc`                                             |
| SSH / GPG agent startup           | `zprofile` or `zlogin`                              |
| Compile `.zcompdump`              | `zlogin`                                            |
| Stop agents on exit               | `zlogout`                                           |
| Machine-specific overrides        | `~/.localrc` (sourced last by `zshenv` and `zshrc`) |

---

## Files in this project

```
zsh/config/
  zshenv.zsh      → ~/.zshenv    (env vars, PATH — all shells)
  zprofile.zsh    → ~/.zprofile  (login setup: EDITOR, LANG, LESS)
  zshrc.zsh       → ~/.zshrc     (interactive config: prompt, aliases, completion)
  zlogin.zsh      → ~/.zlogin    (post-login: compile zcompdump)
  zlogout.zsh     → ~/.zlogout   (cleanup on exit)
  path.zsh        sourced by zshenv — base PATH and Homebrew
  config.zsh      sourced by zshrc — setopts, history, key bindings
  completion.zsh  sourced by zshrc — zstyle completion tuning
  aliases.zsh     sourced by zshrc — command aliases
  prompt.zsh      sourced by zshrc — prompt setup
  plugins.zsh     sourced by zshrc — minimal plugin loading
  directories.zsh sourced by zshrc — cdpath and named dirs
```

Symlinks are created by `zsh/setup.sh`, which is run automatically by `zdot setup`.
