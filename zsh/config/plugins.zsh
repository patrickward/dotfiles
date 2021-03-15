# Plugins Configuration

## NVM
export NVM_DIR="$HOME/.config/nvm"
export NVM_LAZY=1
# export NVM_AUTOLOAD=1


## Don't expand these in globalias
GLOBALIAS_FILTER_VALUES=(l ll la cd grep heroku man mkkdir mysql cpi lni mvi rmi)

# Load plugin files
find -H "$DOTFILES/zsh/plugins" -maxdepth 1 -name "*.zsh" | while read -r file; do source "$file"; done

