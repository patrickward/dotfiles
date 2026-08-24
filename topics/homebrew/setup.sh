#!/usr/bin/env bash
# topics/homebrew/setup.sh
# Install Homebrew packages from Brewfile

is_macos || return 0

if ! command -v brew &>/dev/null; then
    warn "Homebrew not found — skipping brew bundle"
    return 1
fi

info "Installing Homebrew packages from Brewfile..."
brew bundle --file="$DOTFILES/topics/homebrew/Brewfile"
okay "Homebrew packages installed"
