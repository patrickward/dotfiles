#!/usr/bin/env bash
# topics/vim/setup.sh

. "$DOTFILES/lib/utils.sh"

# Link the vim directory
link_file "${DOTFILES}/topics/vim" "$HOME/.vim"

# vim-plug is installed on-demand via :PlugInstall
# The plug.vim file is stored in ~/.vim/autoload/plug.vim
