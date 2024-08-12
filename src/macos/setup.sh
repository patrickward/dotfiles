. "$DOTFILES/lib/utils.sh"

if [[ "$OSTYPE" == darwin* ]]; then
  info "Setting Mac OS X defaults"
  # Disable press-and-hold for keys in favor of key repeat.
  info "macOS: ApplePressAndHoldEnabled"
  defaults write -g ApplePressAndHoldEnabled -bool false

  # Use AirDrop over every interface. srsly this should be a default.
  info "macOS: NetworkBrowser"
  defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

  # Always open everything in Finder's list view. This is important.
  info "macOS: Finder style Nlsv"
  defaults write com.apple.Finder FXPreferredViewStyle Nlsv

  # Show the ~/Library folder.
  info "macOS: nohidden ~/Library"
  chflags nohidden ~/Library

  # Set a really fast key repeat.
  info "macOS: NSGlobalDomain KeyRepeat"
  defaults write NSGlobalDomain KeyRepeat -int 1

  # Set the Finder prefs for showing a few different volumes on the Desktop.
  info "macOS: ShowExternalHardDrivesOnDesktop"
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  info "macOS: ShowRemovableMediaOnDesktop"
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

  # Run the screensaver if we're in the bottom-left hot corner.
  # defaults write com.apple.dock wvous-bl-corner -int 5
  # defaults write com.apple.dock wvous-bl-modifier -int 0

  # Hide Safari's bookmark bar.
  # info "macOS: ShowFavoritesBar false"
  # defaults write com.apple.Safari ShowFavoritesBar -bool false

  # Set up Safari for development.
  # info "safari: IncludeInternalDebugMenu"
  # defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
  # info "safari: IncludeDevelopMenu"
  # defaults write com.apple.Safari IncludeDevelopMenu -bool true
  # info "safari: WebKitDeveloperExtrasEnabledPreferenceKey"
  # defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  # info "safari: com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled"
  # defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
  # info "macOS: NSGlobalDomain WebKitDevelopersExtra"
  # defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

  # Default screenshots to the Downloads folder
  info "macOS: write com.apple.screencapture location ~/Downloads/ && killall SystemUIServer"
  defaults write com.apple.screencapture location ~/Downloads/ && killall SystemUIServer

fi
