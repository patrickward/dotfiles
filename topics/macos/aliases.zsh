# topics/macos/aliases.zsh
#
# macOS-specific aliases and shortcuts.

[[ "$OSTYPE" != darwin* ]] && return

# ---------------------------------------------------------------------------
# Clipboard
# ---------------------------------------------------------------------------
alias pbc='pbcopy'
alias pbp='pbpaste'

# ---------------------------------------------------------------------------
# Finder integration
# Requires pfd/pfs functions from zsh/functions/
# ---------------------------------------------------------------------------
alias cdf='cd "$(pfd)"'         # cd to current Finder directory
alias pushdf='pushd "$(pfd)"'   # pushd to current Finder directory

# ---------------------------------------------------------------------------
# System toggles
# ---------------------------------------------------------------------------
alias macos-show-hidden='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias macos-hide-hidden='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'
alias macos-screenshots-to-downloads='defaults write com.apple.screencapture location ~/Downloads/ && killall SystemUIServer'
alias macos-disable-touchid='sudo bioutil -w -s -f 0'
