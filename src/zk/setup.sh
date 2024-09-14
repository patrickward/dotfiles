. "$DOTFILES/lib/utils.sh"
mkdir -p "$XDG_CONFIG_HOME/zk"
mkdir -p "$HOME/notes/daily"
mkdir -p "$HOME/notes/standup"
mkdir -p "$HOME/notes/projects"
mkdir -p "$HOME/notes/roadtrips"
link_file "${DOTFILES}/src/zk/config.toml" "$XDG_CONFIG_HOME/zk/config.toml"
link_file "${DOTFILES}/src/zk/templates" "$XDG_CONFIG_HOME/zk/templates"
