# Mac OS X aliases

if [[ "$OSTYPE" == darwin* ]]; then

  # Show/hide hidden files in Finder
  alias show-dotfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
  alias hide-dotfiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

  # pb commands
  pbc=pbcopy
  pbp=pbpaste

  # finder commands

  # Changes directory to the current Finder directory.
  alias cdf='cd "$(pfd)"'

  # Pushes directory to the current Finder directory.
  alias pushdf='pushd "$(pfd)"'

  # Show hidden files in Finder
  alias showHiddenFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'

  # Hide hidden files in Finder
  alias hideHiddenFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

  # Flush local DNS
  alias flushDns='sudo killall -HUP mDNSResponder;say DNS cache has been flushed'

fi
