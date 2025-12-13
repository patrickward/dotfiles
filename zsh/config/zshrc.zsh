
# PROFILE: zmodload zsh/zprof
# TEST: for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done
#
# zshenv -> zprofile -> zshrc -> zlogin
#

if [[ -a $HOME/.localrc ]]; then source "$HOME/.localrc"; fi


# !! config_files set in zshenv

# Load config
source "$DOTFILES/zsh/config/config.zsh"

# Load aliases
source "$DOTFILES/zsh/config/aliases.zsh"

# Load all topic zsh files, except for path.zsh, completion.zsh, and config directories
# path.zsh has already been loaded and completion.zsh files will be loaded in .zshrc
for file in ${${${config_files:#*/src/*path.zsh}:#*/src/*completion.zsh}:#*/config/*}; do
    source $file
done || true

# Initialize autocomplete here, otherwise functions won't be loaded
autoload -Uz compinit
comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))
if (( $#comp_files )); then
  compinit -i -C
else
  compinit -i
fi

unset comp_files

# Load completion files after autocomplete loads
for file in ${(M)config_files:#*/*completion.zsh}; do source $file; done

unset config_files
unset comp_files

# Better history
#
# Credits to https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# resets the path and interferes with their location within the path
if [[ "$OSTYPE" == darwin* ]]; then

  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

  # export PATH="$HOME/anaconda3/bin:$PATH"  # commented out by conda initialize
  export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
  # Add gnu grep in place of mac os x bsd based grep
  export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
  # Add gnu sed in place of mac os x bsd based sed
  export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

  # Adding pandoc in front of anaconda, as the anaconda version overwrites it
  export PATH="/usr/local/opt/pandoc/bin:$PATH"

fi

# Set prompt
source "$DOTFILES/zsh/config/prompt.zsh"

# Finally, ensure tmux is running
ensure_tmux_is_running

# Load plugins
source "$DOTFILES/zsh/config/plugins.zsh"

# Load directories
source "$DOTFILES/zsh/config/directories.zsh"

# Load asdf last
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Load rbenv
# eval "$(rbenv init - zsh)"

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# arm64
# export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# i386
# This needs to be exported when install the `pg` ruby gem
# as the ruby install is completed under i386 and the pg gem needs
# a corresponding install of the libpg under i386
export PATH="/usr/local/homebrew/opt/libpq/bin:$PATH"

# Ensure PHP@7.2 is exported last to override 8.0
export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"
export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"

# Work-around for dealing with pg gem x86 incompatibilities
#export PATH="${HOMEBREW_PREFIX}/opt/postgresql/bin:$PATH"
# export PATH="${HOMEBREW_PREFIX}/opt/postgresql@15/bin:$PATH"

# Ensure dart sass is at the beginning of the path
export PATH="/opt/homebrew/opt/sass/bin:$PATH"

# Ensure postgresql flags are set
# export LDFLAGS="-L${HOMEBREW_PREFIX}/opt/postgresql@14/lib"
# export CPPFLAGS="-I${HOMEBREW_PREFIX}/opt/postgresql@14/include"
# export LDFLAGS="-L${HOMEBREW_PREFIX}/opt/postgresql@15/lib"
# export CPPFLAGS="-I${HOMEBREW_PREFIX}/opt/postgresql@15/include"

# Ensure Flutter's dart is at the front
export PATH="/Users/patrick/code/bin/flutter/bin:$PATH"

# #nsure postgresql.app is at the front
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# Ensure local bin is at the front of path
export PATH="$HOME/bin:$PATH"

# Ensure we're using the proper GOROOT path
export PATH="$HOME/go/bin:$PATH"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/patrick/.config/.dart-cli-completion/zsh-config.zsh ]] && . /Users/patrick/.config/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

# Finally, show the mycommands hint:
# Show hint only for interactive login shells
if [[ -o login ]]; then
    echo "💡 Type 'quickref' to see custom commands"
fi

