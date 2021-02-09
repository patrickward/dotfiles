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
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Stash local environment variables in ~/.localrc so that
# they stay out of the dotfiles repository and not available to the public
if [[ -a $HOME/.localrc ]]; then source "$HOME/.localrc"; fi

# Find all zsh files in each directory under zsh
typeset -U config_files
config_files=("$DOTFILES"/zsh/**/*.zsh "$DOTFILES"/topics/*/*.zsh)
# Source all path files
source "$DOTFILES/zsh/config/path.zsh"
for file in ${(M)config_files:#*/topics/*path.zsh}; do
    source $file
done

# Load config
source "$DOTFILES/zsh/config/config.zsh"

# Load aliases
source "$DOTFILES/zsh/config/aliases.zsh"

# Load all topic zsh files, except for path.zsh, completion.zsh, and config directories
# path.zsh has already been loaded and completion.zsh files will be loaded in .zshrc
for file in ${${${config_files:#*/topics/*path.zsh}:#*/topics/*completion.zsh}:#*/config/*}; do
    source $file
done
