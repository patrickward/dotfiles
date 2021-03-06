# Mac OS X aliases

if [[ "$OSTYPE" == darwin* ]]; then

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

  # Make sure screenshots go to the Downloads folder
  alias screenshotsToDownloads='defaults write com.apple.screencapture location ~/Downloads/ && killall SystemUIServer'

  # Turn off touch id temporarily, until the user turns it back on
  alias disableTouchID='sudo bioutil -w -s -f 0'

fi
