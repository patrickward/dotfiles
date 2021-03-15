# Stash local environment variables in ~/.localrc so that
# they stay out of the dotfiles repository and not available to the public
if [[ -a $HOME/.localrc ]]; then source "$HOME/.localrc"; fi

# Find all zsh files directory under src
typeset -U config_files
# Note the maxdepth of 1 for each specific subdirectory in src; this prevents deep
# searches into larger directories, such as vim/bundle/*. This means, only *.zsh files
# in the immediate subdirectory will be considered when loading files
config_files=("$DOTFILES"/src/*/*.zsh) 1> /dev/null

# Source all path files
source "$DOTFILES/zsh/config/path.zsh"
for file in ${(M)config_files:#*/src/*path.zsh}; do
    source $file
done

# Load config
source "$DOTFILES/zsh/config/config.zsh"

# Load aliases
source "$DOTFILES/zsh/config/aliases.zsh"

# Load all topic zsh files, except for path.zsh, completion.zsh, and config directories
# path.zsh has already been loaded and completion.zsh files will be loaded in .zshrc
for file in ${${${config_files:#*/src/*path.zsh}:#*/src/*completion.zsh}:#*/config/*}; do
    source $file
done || true

# PROFILE: zmodload zsh/zprof
# TEST: for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done
#
# zshenv -> zprofile -> zshrc -> zlogin
#

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

# Run the rbenv command later in the process
# source ~/.dotfiles/zsh/ruby/rbenv.sh

# Need to add the following after rbenv as rbenv
# resets the path and interferes with their location within the path
if [[ "$OSTYPE" == darwin* ]]; then

  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

  export PATH="$HOME/anaconda3/bin:$PATH"
  export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
  # Add gnu grep in place of mac os x bsd based grep
  export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
  # Add gnu sed in place of mac os x bsd based sed
  export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

fi

# Set prompt
source "$DOTFILES/zsh/config/prompt.zsh"

# Finally, ensure tmux is running
ensure_tmux_is_running

# Load plugins
source "$DOTFILES/zsh/config/plugins.zsh"

# Load directories
source "$DOTFILES/zsh/config/directories.zsh"

