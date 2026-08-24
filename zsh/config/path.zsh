# zsh/config/path.zsh
#
# Base PATH configuration. Loaded from zshenv before topic path.zsh files.
#
# Rules:
#   1. No hardcoded usernames or machine-specific paths
#   2. No topic-specific paths (go, rust, python, etc. belong in their topics)
#   3. Use typeset -U (set in zshenv) to deduplicate automatically
#   4. OS-conditional paths are gated with is_macos/is_linux
#
# Path precedence (first wins): local bin → dotfiles bin → brew → system

# ---------------------------------------------------------------------------
# Local bin directories: always first in PATH
# $HOME/bin: personal scripts (not topic-specific)
# $HOME/.local/bin: standard XDG location for user-installed binaries
# $DOTFILES/bin: zdot and git helpers from this repo
# ---------------------------------------------------------------------------
path=("$HOME/bin" "$HOME/.local/bin" "$DOTFILES/bin" $path)

# ---------------------------------------------------------------------------
# Homebrew: initialize if present
#
# `brew shellenv` sets PATH, MANPATH, INFOPATH, HOMEBREW_PREFIX, etc.
# We check the canonical locations for Apple Silicon and Intel macOS,
# and for Linux (Linuxbrew). If brew isn't installed, this block is skipped.
# ---------------------------------------------------------------------------
if [[ -x "/opt/homebrew/bin/brew" ]]; then
    # Apple Silicon macOS
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x "/usr/local/bin/brew" ]]; then
    # Intel macOS
    eval "$(/usr/local/bin/brew shellenv)"
elif [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    # Linux (Linuxbrew)
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ---------------------------------------------------------------------------
# System paths: ensure standard system directories are present
# /usr/local/bin and /usr/local/sbin are not always in the default PATH
# on minimal Linux installs or after shell changes.
# ---------------------------------------------------------------------------
path=($path /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /bin /sbin)
