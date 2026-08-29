#!/usr/bin/env zsh
# topics/ghostty/setup.sh
#
# Symlinks the ghostty config into ~/.config/ghostty/.
# Sourced by `zdot setup`, which provides link_file and $DOTFILES.

mkdir -p "$XDG_CONFIG_HOME/ghostty"
link_file "$DOTFILES/topics/ghostty/config.ghostty" "$XDG_CONFIG_HOME/ghostty/config.ghostty"
