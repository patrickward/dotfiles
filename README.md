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
os/
  macos/            macOS-specific setup (Brewfile, defaults.sh)
  linux/            Linux-specific setup
topics/                Topics — one directory per tool/concern
  git/
  go/
  nvim/
  ...
zsh/
  config/           Core zsh config (path, aliases, prompt, completion)
  functions/        Autoloaded zsh functions
```

## Topics

Each directory under `topics/` is a topic. A topic can contain:

| File             | Purpose                                |
|------------------|----------------------------------------|
| `path.zsh`       | PATH modifications (loaded in zshenv)  |
| `*.zsh`          | Anything sourced in interactive shells |
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

## After macOS Updates

System updates can break symlinks. Run `zdot status` to check.

## Next Steps

We can now walk through any of the remaining files in detail:

- zsh/config/config.zsh — shell options, history settings
- zsh/config/aliases.zsh — clean up and organize
- zsh/config/prompt.zsh — pure prompt config
- zsh/config/plugins.zsh — globalias and anything else
- Individual topic setup.sh files — git, go, nvim, homebrew
- localrc.template — template for the gitignored local overrides (where Herd, company tools, etc. go)
- 
The ~/.localrc pattern is actually where Herd's injections, the PHP version pins, dart-cli-completion, etc. belong — they're machine-specific and shouldn't be committed. We can set up a local.zsh.template as a starting point.
