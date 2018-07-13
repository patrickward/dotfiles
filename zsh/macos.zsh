# Mac OS X aliases

# Show/hide hidden files in Finder
alias show-dotfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hide-dotfiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# pb commands
pbc=pbcopy
pbp=pbpaste
