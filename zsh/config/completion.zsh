# zsh/config/completion.zsh
#
# zstyle completion configuration. Sourced by zshrc.zsh before compinit so
# these settings are in effect when the completion system initialises.
#
# setopt flags (COMPLETE_IN_WORD, AUTO_MENU, etc.) live in config.zsh.
# This file is for zstyle directives that tune completion behaviour.

# ---------------------------------------------------------------------------
# Completion matching
#
# Case-insensitive completion for lowercase input only: typing 'foo' matches
# 'Foo' but typing 'FOO' does not match 'foo'. This is the most ergonomic
# default — you can still match exactly when you use uppercase.
# ---------------------------------------------------------------------------
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ---------------------------------------------------------------------------
# Completer order
#
# Try exact completion first, then fall back to approximate (correcting up to
# 1 error). _expand_alias runs before _complete so aliases expand in
# completions the same way they do on the command line.
# ---------------------------------------------------------------------------
zstyle ':completion:*' completer _expand_alias _complete _approximate

# ---------------------------------------------------------------------------
# Approximate completion: allow at most 1 error for short words, 2 for longer
# ---------------------------------------------------------------------------
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# ---------------------------------------------------------------------------
# Menu / list appearance
# ---------------------------------------------------------------------------
zstyle ':completion:*' menu select                      # Always show a menu (navigable with arrow keys)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Color completions using $LS_COLORS
zstyle ':completion:*' insert-tab pending               # Insert a tab rather than completing when line is empty

# ---------------------------------------------------------------------------
# Grouping: show candidates grouped by description (e.g. "files", "commands")
# ---------------------------------------------------------------------------
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group yes
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:messages' format '%F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'

# ---------------------------------------------------------------------------
# Process completion: show all processes for kill/killall
# ---------------------------------------------------------------------------
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# ---------------------------------------------------------------------------
# Directory completion: don't complete . and .. in directory listing
# ---------------------------------------------------------------------------
zstyle ':completion:*' special-dirs false

# ---------------------------------------------------------------------------
# Caching: store completion cache for commands that are slow to complete
# (e.g. large package managers). Cache is written to $XDG_CACHE_HOME/zsh.
# ---------------------------------------------------------------------------
zstyle ':completion::complete:*' use-cache yes
zstyle ':completion::complete:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
