# Setting XDG_CONFIG_HOME environment
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# Set the dotfiles directory based on the zshenv file itself
export DOTFILES
if [[ -L "$HOME/.zshenv" ]]
then
  DOTFILES=$(dirname "$(readlink "$HOME/.zshenv")")
else
  DOTFILES=$(dirname "$HOME/.zshenv")
fi
DOTFILES="${DOTFILES%/zsh/config}"

# Tell Zsh to use XDG_CONFIG_HOME
# export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Tell Vim to use XDG_CONFIG_HOME
# export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

# Ensure that a non-login, non-interactive shell has a defined environment.
# if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
#   source "${ZDOTDIR:-$HOME}/.zprofile"
# fi

