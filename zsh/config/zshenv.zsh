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

# Remove the zsh/config suffix
DOTFILES="${DOTFILES%/zsh/config}"

# Tell Zsh to use the home directory
export ZDOTDIR="$HOME"

# Tell Zsh to use XDG_CONFIG_HOME
# export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Tell Vim to use XDG_CONFIG_HOME
# export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

# Ensure that a non-login, non-interactive shell has a defined environment.
# if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
#   source "${ZDOTDIR:-$HOME}/.zprofile"
# fi

# Stash local environment variables in ~/.localrc so that
# they stay out of the dotfiles repository and not available to the public

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

# Switch to an arm64e shell by default
if [ $(machine) != arm64e ]; then
    if [[ -z ${USING_ARCH_X86_64} ]]; then
       exec arch -arm64 zsh
    fi
fi

# Adding rustup
. "/Users/patrick/.config/cargo/env"
