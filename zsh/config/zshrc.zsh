# PROFILE: zmodload zsh/zprof
# TEST: for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done
#
# zshenv -> zprofile -> zshrc -> zlogin
#

# NOTE: SEE zshenv.symlink for all of the sourced files

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

# Load plugin files
find -H "$DOTFILES/zsh/plugins" -maxdepth 1 -name "*.zsh" | while read -r file; do source "$file"; done

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

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
