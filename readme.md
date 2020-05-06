crip My personal dotfiles

This is largely a collection of dotfiles and techniques that I've cobbled together.

I wanted a cleaner zsh environment without the cruft of a zsh framework.

I used the [holman dotfiles](https://github.com/holman/dotfiles) as a major inspiration, but found that a lot of what was in there wasn't what I needed or would use. So, I made some changes to suit my needs.

I also wanted the symlinks and directories to match the final structure that the home directory would show. So, there are quite a few modifications that don't match the topic style of that project.

## Local Overrides

Set local environment variables and overrides in `$HOME/.localrc`.

For example, the following are good to include in .localrc

```
# Github token password for CLI use
export GITHUB_TOKEN=???

# GaTech Github token password for CLI use
export GT_GITHUB_TOKEN=???

# Local notes directory
export NOTES_DIR=???

# Ensure a new zsh session automatically enters a tmux session
export ENSURE_TMUX_IS_RUNNING=1
```

## components

_Instructions are from holman as the scripts are essentially the same, but the directory structure has changed._

There are a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **Brewfile**: This is a list of applications for [Homebrew Cask](https://caskroom.github.io) to install: things like Chrome and 1Password and Adium and stuff. Might want to edit this file before running any initial setup.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `bootstrap/bootstrap`.

## install

Run this:

```sh
git clone https://github.com/patrickward/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bootstrap/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

`dot` is a simple script that installs some dependencies, sets sane macOS
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.


