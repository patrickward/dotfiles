# Plugins Configuration

## Don't expand these in globalias
GLOBALIAS_FILTER_VALUES=(
  cd
  cpi
  grep
  heroku
  l
  la
  ll
  lni
  man
  marz
  mkdir
  modz
  mvi
  mysql
  rmi
  t
  vim
)

# Load plugin files
find -H "$DOTFILES/zsh/plugins" -maxdepth 1 -name "*.zsh" | while read -r file; do source "$file"; done

