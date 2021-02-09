. "$DOTFILES/lib/utils.sh"

if [[ "$OSTYPE" == darwin* ]]; then
  # From: https://github.com/holman/dotfiles
  # Command line interface for updating Mac App Store installables
  sudo softwareupdate -i -a
fi
