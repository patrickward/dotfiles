#!/usr/bin/env bash
# topics/vim/setup.sh

. "$DOTFILES/lib/utils.sh"

# Link the vim directory
link_file "${DOTFILES}/topics/vim" "$HOME/.vim"

# Run the plugin installation
"$DOTFILES/topics/vim/bin/install-plugins.sh"

