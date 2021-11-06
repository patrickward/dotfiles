
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

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
