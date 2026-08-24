# src/mise/path.zsh
#
# mise: universal runtime version manager (go, node, python, ruby, elixir, etc.)
# https://mise.jdx.dev
#
# This file adds mise's shims directory to PATH so that version-managed
# binaries are available. The full activation (which sets up hooks for
# automatic version switching) happens in zshrc via `mise activate zsh`.

if is_macos; then
    # Homebrew installs mise here on macOS
    path=("$(brew_prefix)/bin" $path)  # brew is already in path; this is a no-op if so
fi

# mise's data dir defaults to ~/.local/share/mise
# Shims live at ~/.local/share/mise/shims — mise activate handles this,
# but listing it explicitly makes PATH inspection easier
path=("${XDG_DATA_HOME:-$HOME/.local/share}/mise/shims" $path)
