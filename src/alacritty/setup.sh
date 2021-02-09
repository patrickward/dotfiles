. "$DOTFILES/lib/utils.sh"
mkdir -p "$XDG_CONFIG_HOME/alacritty"
link_file "${DOTFILES}/src/alacritty/alacritty.yml" "$XDG_CONFIG_HOME/alacritty/alacritty.yml"
