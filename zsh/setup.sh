#!/usr/bin/env zsh
# zsh/setup.sh
#
# Symlinks the zsh startup files into $HOME so the shell picks them up.
# Sourced by `zdot setup`, which provides link_file and $DOTFILES.
#
# Load order (zsh startup sequence):
#   ~/.zshenv    — all shells (env vars, PATH)
#   ~/.zprofile  — login shells, before zshrc
#   ~/.zshrc     — interactive shells
#   ~/.zlogin    — login shells, after zshrc
#   ~/.zlogout   — login shells, on exit

link_file "$DOTFILES/zsh/config/zshenv.zsh"   "$HOME/.zshenv"
link_file "$DOTFILES/zsh/config/zprofile.zsh"  "$HOME/.zprofile"
link_file "$DOTFILES/zsh/config/zshrc.zsh"     "$HOME/.zshrc"
link_file "$DOTFILES/zsh/config/zlogin.zsh"    "$HOME/.zlogin"
link_file "$DOTFILES/zsh/config/zlogout.zsh"   "$HOME/.zlogout"
