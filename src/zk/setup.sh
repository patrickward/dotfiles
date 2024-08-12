. "$DOTFILES/lib/utils.sh"
mkdir -p "$HOME/notes"
link_file "${DOTFILES}/src/zk/config.toml" "$HOME/notes/.zk/config.toml"
link_file "${DOTFILES}/src/zk/templates" "$HOME/notes/.zk/templates"
