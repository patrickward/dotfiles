#!/usr/bin/env bash
# topics/macos/setup.sh
#
# Apply sensible macOS defaults for a development machine.
# Run once on a new machine. Safe to re-run.

. "$DOTFILES/lib/utils.sh"

[[ "$OSTYPE" != darwin* ]] && { info "Skipping macOS setup on non-macOS"; exit 0; }

info "Applying macOS defaults..."

# Disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Set a fast key repeat rate (1 = fastest)
defaults write NSGlobalDomain KeyRepeat -int 1

# Always open everything in Finder's list view
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the ~/Library folder
chflags nohidden ~/Library

# Show external drives and removable media on the Desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Use AirDrop over every interface
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Default screenshots to Downloads folder
defaults write com.apple.screencapture location ~/Downloads/
killall SystemUIServer 2>/dev/null || true

okay "macOS defaults applied"
warn "Some changes require logout or restart to take effect"
