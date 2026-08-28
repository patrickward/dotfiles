# dotfiles

This is my personal shell configuration for macOS and Linux. Managed by `bin/zdot`. It's a rewrite of a set of scripts I've used over the past couple of decades.  

## Requirements

- zsh
- git
- macOS: Homebrew (bootstrap installs it)
- Linux: apt-based (extend `bootstrap.sh` for other package managers)

## Quick Start

```sh
# On a fresh machine:
bash <(curl -fsSL https://raw.githubusercontent.com/patrickward/dotfiles/main/bootstrap.sh)

# Or, after cloning manually:
git clone https://github.com/patrickward/dotfiles ~/dotfiles
bash ~/dotfiles/bootstrap.sh
```

`bootstrap.sh` installs prerequisites (Xcode CLT on macOS, Homebrew), then
calls `zdot setup` to install symlinks and run topic setup scripts.

## Usage

```sh
zdot setup              # Install everything
zdot setup git          # Install only the git topic
zdot setup --dry-run    # Preview without changes
zdot status             # Verify all symlinks are intact
zdot setdown            # Remove tracked symlinks
zdot update             # Run all update.sh scripts
```

## Structure

```
bootstrap.sh        Entry point for fresh machines
bin/zdot            Dotfiles manager (see docs/zdot.md)
lib/utils.sh        Shared shell utilities and OS detection
local/
  localrc.template  Template for machine-specific overrides (~/.localrc)
topics/             One file or directory per tool
  mise.zsh          shell-config-only tool (flat file)
  git/              tool with symlinks or setup.sh (directory)
    gitconfig.symlink
    gitignore.symlink
    setup.sh
  ...
zsh/
  config/           Core zsh config (path, aliases, prompt, completion)
  functions/        Autoloaded zsh functions
```

## Topics

A topic is either a flat `.zsh` file or a directory, depending on what it needs:

| Form                   | When to use                              |
|------------------------|------------------------------------------|
| `topics/tool.zsh`      | Tool needs only shell config (PATH, aliases, init) |
| `topics/tool/`         | Tool needs symlinked dotfiles or a `setup.sh` |

Files recognized inside a topic directory:

| File             | Purpose                                |
|------------------|----------------------------------------|
| `*.zsh`          | Sourced in interactive shells          |
| `completion.zsh` | Completions (loaded after compinit)    |
| `setup.sh`       | Run once on setup (installs, config)   |
| `install.sh`     | Run by `zdot install`                  |
| `update.sh`      | Run by `zdot update`                   |
| `*.symlink`      | Symlinked to `~/.<filename>`           |

## Local Overrides

`~/.localrc` is sourced last and is gitignored. Put machine-specific
config here: API tokens, work-specific PATH entries, tool injections
(e.g., Herd, company proxies). See `local/localrc.template`.

## Cross-Platform

OS detection is available in all scripts via `lib/utils.sh`:

```sh
is_macos && brew install something
is_linux && sudo apt-get install -y something
```

Topic `setup.sh` scripts gate themselves. The same repo works on both platforms.

## Local Dev Stack

See [`docs/brew.md`](docs/brew.md) for the local dev reference: Caddy, dnsmasq, PHP, Go, Python, mise, Mailpit, Redis, ngrok, and per-language project setup.

Caddy-specific site snippet examples live in [`docs/caddy.md`](docs/caddy.md).

## After macOS Updates

System updates can break symlinks. Run `zdot status` to check.

