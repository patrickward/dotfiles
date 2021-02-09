#!/usr/bin/env bash

. "$DOTFILES/lib/utils.sh"

# Check for Homebrew
if ! command -v brew &> /dev/null
then
  info "Installing homebrew"
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

exit 0
