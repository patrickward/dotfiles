#!/usr/bin/env zsh
# lib/utils.sh
#
# Shared utilities for zdot and setup scripts.
# Sourced by bin/zdot and available to all setup.sh/install.sh scripts.
#
# Note: This file uses zsh-specific features (autoload, ${fg[...]}).
# It is NOT compatible with /bin/sh or bash. bootstrap.sh has its own
# plain-bash equivalents for the pre-zsh bootstrap phase.

# ---------------------------------------------------------------------------
# Color output helpers
# For color codes reference: https://unix.stackexchange.com/a/408871
# ---------------------------------------------------------------------------

autoload colors; colors  # Enables the ${fg[color]} and $reset_color variables

info() { echo "${fg[blue]}  [info] $1$reset_color"; }
warn() { echo "${fg[yellow]}  [warn] $1$reset_color"; }
okay() { echo "${fg[green]}    [ok] $1$reset_color"; }
fail() { echo "${fg[red]}  [fail] $1$reset_color"; }

# ---------------------------------------------------------------------------
# Prompt helpers
#
# asks: single-keypress prompt (no Enter required), result in $REPLY
# askl: full-line prompt (Enter required), result in $REPLY
# ---------------------------------------------------------------------------

asks() {
    # -s: silent (don't echo key), -k 1: read exactly 1 character
    # "|| true" prevents a 'n' response from returning non-zero and
    # triggering set -e early exit
    read -r -s -k 1 "REPLY?$(warn "$1")"
    echo ""
}

askl() {
    read -r "REPLY?$(warn "$1") "
}

# ---------------------------------------------------------------------------
# OS and architecture detection
#
# Use these guards in setup.sh scripts to gate platform-specific steps.
# All functions return 0 (true) or 1 (false) per shell convention.
#
# Examples:
#   is_macos && brew install something
#   is_linux && sudo apt-get install -y something
# ---------------------------------------------------------------------------

is_macos() { [[ "$OSTYPE" == darwin* ]]; }
is_linux() { [[ "$OSTYPE" == linux-gnu* || "$OSTYPE" == linux* ]]; }
is_arm()   { [[ "$(uname -m)" == "arm64" || "$(uname -m)" == "aarch64" ]]; }
is_x86()   { [[ "$(uname -m)" == "x86_64" ]]; }

# Homebrew prefix varies by OS and architecture:
#   Apple Silicon macOS:  /opt/homebrew
#   Intel macOS:          /usr/local
#   Linux (Linuxbrew):    /home/linuxbrew/.linuxbrew
brew_prefix() {
    if is_macos && is_arm; then
        echo "/opt/homebrew"
    elif is_macos; then
        echo "/usr/local"
    else
        echo "/home/linuxbrew/.linuxbrew"
    fi
}

# ---------------------------------------------------------------------------
# link_file: create a symlink from src → dst
#
# Conflict resolution is controlled by $LINK_FILE_BEHAVIOR:
#   s = skip (leave existing file alone)
#   o = overwrite (remove existing, create symlink)
#   b = backup (rename existing to *.backup, create symlink)
#
# All symlinks created are appended to ZDOT_SYMLINKS for tracking.
# This allows `zdot setdown` to cleanly remove everything zdot installed.
# ---------------------------------------------------------------------------
link_file() {
    local src="$1"
    local dst="$2"
    local skip=false

    if [[ -f "$dst" || -d "$dst" || -L "$dst" ]]; then
        local currentSrc
        currentSrc="$(readlink "$dst")"

        if [[ "$currentSrc" == "$src" ]]; then
            # Symlink already points to the right place — idempotent, skip
            skip=true
            info "Already linked: $dst"
        elif [[ "$LINK_FILE_BEHAVIOR" == "s" ]]; then
            skip=true
            warn "Skipped (conflict): $dst"
        elif [[ "$LINK_FILE_BEHAVIOR" == "o" ]]; then
            rm -rf "$dst"
            warn "Removed (overwrite): $dst"
        elif [[ "$LINK_FILE_BEHAVIOR" == "b" ]]; then
            mv "$dst" "${dst}.backup"
            info "Backed up: $dst → ${dst}.backup"
        fi
    fi

    # Record in symlinks manifest regardless of skip status,
    # so `zdot status` can verify all expected links
    echo "$dst" >> "$ZDOT_SYMLINKS"

    if [[ "$skip" != true ]]; then
        if [[ "${ZDOT_DRY_RUN:-0}" == "1" ]]; then
            info "[dry-run] Would link: $src → $dst"
        else
            ln -s "$src" "$dst"
            okay "Linked: $src → $dst"
        fi
    fi
}

# ---------------------------------------------------------------------------
# join_by: join array elements with a delimiter
# Usage: join_by "," a b c  →  "a,b,c"
# ---------------------------------------------------------------------------
join_by() {
    local IFS="$1"
    shift
    echo "$*"
}
