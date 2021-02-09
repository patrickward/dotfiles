#!/usr/bin/env bash

cd "$DOTFILES" || exit

brew bundle
brew upgrade
brew clean
