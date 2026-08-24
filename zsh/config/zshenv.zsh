# zsh/config/zshenv.zsh
#
# Loaded first, for ALL shell types (interactive, non-interactive, login, script).
# Rules: set environment variables only. No output. No aliases. No prompts.
# Keep this fast — it runs for every zsh invocation including scripts.
#
# Load order: zshenv → zprofile (login) → zshrc (interactive) → zlogin (login)

# ---------------------------------------------------------------------------
# XDG Base Directory Spec
# https://specifications.freedesktop.org/basedir-spec/latest/
#
# Many modern tools respect these. Setting them here means topic configs
# can use $XDG_CONFIG_HOME instead of hardcoding ~/.config.
# ---------------------------------------------------------------------------
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# ---------------------------------------------------------------------------
# DOTFILES: resolve the repo root from the location of this file.
#
# This file is symlinked to ~/.zshenv. We follow the symlink to find
# the actual file's location, then strip the /zsh/config suffix to get
# the repo root. This means DOTFILES is always correct regardless of
# where you've cloned the repo.
# ---------------------------------------------------------------------------
export DOTFILES
if [[ -L "$HOME/.zshenv" ]]; then
    # Follow the symlink: ~/.zshenv → /path/to/dotfiles/zsh/config/zshenv.zsh
    DOTFILES="$(dirname "$(readlink "$HOME/.zshenv")")"
else
    DOTFILES="$(dirname "$HOME/.zshenv")"
fi
# Strip the trailing /zsh/config to get the repo root
DOTFILES="${DOTFILES%/zsh/config}"

# ---------------------------------------------------------------------------
# ZDOTDIR: tells zsh where to find .zshrc, .zprofile, .zlogin, .zlogout
#
# Keeping this at $HOME (default) because macOS and many tools assume
# ~/.zshrc exists. Switching to $XDG_CONFIG_HOME/zsh requires additional
# wiring that isn't worth the complexity for a team setup.
# ---------------------------------------------------------------------------
export ZDOTDIR="$HOME"

# ---------------------------------------------------------------------------
# PATH: load canonical path definitions
#
# path.zsh sets the base PATH (Homebrew, local bin, system dirs).
# Tool-specific PATH additions live in each topic's .zsh file,
# loaded in zshrc for interactive shells.
# We use typeset -U (unique) to deduplicate array entries automatically.
# ---------------------------------------------------------------------------
typeset -gU path cdpath fpath mailpath  # zsh-specific: auto-deduplicate these arrays

source "$DOTFILES/zsh/config/path.zsh"

# ---------------------------------------------------------------------------
# Rust/Cargo: source cargo env if present
#
# Uses $HOME instead of hardcoded /Users/patrick.
# Cargo respects $CARGO_HOME; default is ~/.cargo.
# ---------------------------------------------------------------------------
[[ -f "${CARGO_HOME:-$HOME/.cargo}/env" ]] && source "${CARGO_HOME:-$HOME/.cargo}/env"

# ---------------------------------------------------------------------------
# Local environment overrides
#
# ~/.localrc is gitignored and machine-specific. Use it for:
#   - API keys and tokens (never commit these)
#   - Machine-specific PATH additions
#   - Work vs. personal environment switches
# ---------------------------------------------------------------------------
[[ -f "$HOME/.localrc" ]] && source "$HOME/.localrc"
