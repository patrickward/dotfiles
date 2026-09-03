# topics/macos/aliases.zsh
#
# macOS-specific aliases and shortcuts.

[[ "$OSTYPE" != darwin* ]] && return

# ---------------------------------------------------------------------------
# Clipboard
# ---------------------------------------------------------------------------
alias pbc='pbcopy'    # zref: Run pbcopy
alias pbp='pbpaste'   # zref: Run pbpaste

# ---------------------------------------------------------------------------
# Finder integration
# Requires pfd/pfs functions from zsh/functions/
# ---------------------------------------------------------------------------
alias cdf='cd "$(pfd)"'         # zref: cd to current Finder directory
alias pushdf='pushd "$(pfd)"'   # zref: pushd to current Finder directory

# ---------------------------------------------------------------------------
# System toggles
# ---------------------------------------------------------------------------
# zref: Turn on AppleShowAllFiles in finder
alias macos-show-hidden='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
# zref: Turn off AppleShowAllFiles in finder
alias macos-hide-hidden='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'
# zref: Set all screenshots to go to teh Downloads folder
alias macos-screenshots-to-downloads='defaults write com.apple.screencapture location ~/Downloads/ && killall SystemUIServer'
# zref: Disable the touch ID on macOS
alias macos-disable-touchid='sudo bioutil -w -s -f 0'

# ---------------------------------------------------------------------------
# Architecture switching (macOS / Apple Silicon only)
#
# On M-series Macs, Rosetta 2 allows running Intel binaries under emulation.
#   mzsh: start a native arm64 zsh (Homebrew /opt/homebrew, etc.)
#   izsh: start an x86_64 zsh via Rosetta (for Intel-only tools)
# ---------------------------------------------------------------------------
if [[ "$(uname -s)" == "Darwin" ]]; then
    alias mzsh="arch -arm64 zsh"      # zref: @macos: Start a native arm64 session (macOS only)
    alias izsh="arch -x86_64 zsh"     # zref: @macos: Start a native x86_64 session via Rosetta (macOS only)
fi
