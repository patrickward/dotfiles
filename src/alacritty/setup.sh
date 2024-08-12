. "$DOTFILES/lib/utils.sh"
mkdir -p "$XDG_CONFIG_HOME/alacritty"
link_file "${DOTFILES}/src/alacritty/alacritty.toml" "$XDG_CONFIG_HOME/alacritty/alacritty.toml"
