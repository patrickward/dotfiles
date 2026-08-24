#!/usr/bin/env bash
# bootstrap.sh
#
# Entry point for setting up a new machine. Run this first — it handles
# prerequisites that zdot depends on (Homebrew, git, etc.) and then
# hands off to zdot for the rest.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/patrickward/dotfiles-v2/main/bootstrap.sh | bash
#   OR, after cloning:
#   bash ~/dotfiles/bootstrap.sh
#
# This script is intentionally written in bash (not zsh) because zsh may not
# yet be the login shell, and /bin/bash is guaranteed present on both macOS
# and most Linux distributions.

set -euo pipefail

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/patrickward/dotfiles-v2.git}"

# ---------------------------------------------------------------------------
# Helpers — plain bash versions (lib/utils.sh is zsh, not usable here)
# ---------------------------------------------------------------------------

info()  { printf "\033[34m  [info] %s\033[0m\n" "$1"; }
warn()  { printf "\033[33m  [warn] %s\033[0m\n" "$1"; }
okay()  { printf "\033[32m    [ok] %s\033[0m\n" "$1"; }
fail()  { printf "\033[31m  [fail] %s\033[0m\n" "$1" >&2; }

# ---------------------------------------------------------------------------
# OS detection — used throughout to gate platform-specific steps
# ---------------------------------------------------------------------------

is_macos() { [[ "$OSTYPE" == darwin* ]]; }
is_linux() { [[ "$OSTYPE" == linux-gnu* || "$OSTYPE" == linux* ]]; }
is_arm()   { [[ "$(uname -m)" == "arm64" || "$(uname -m)" == "aarch64" ]]; }

# ---------------------------------------------------------------------------
# Step 1: Clone or update the dotfiles repo
# ---------------------------------------------------------------------------

if [[ -d "$DOTFILES_DIR/.git" ]]; then
    info "Dotfiles repo already present at $DOTFILES_DIR — pulling latest..."
    git -C "$DOTFILES_DIR" pull --ff-only
else
    info "Cloning dotfiles repo to $DOTFILES_DIR..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

okay "Dotfiles repo ready"

# ---------------------------------------------------------------------------
# Step 2: Platform-specific package manager bootstrap
# ---------------------------------------------------------------------------

if is_macos; then

    # Install Xcode Command Line Tools if absent.
    # This provides git, make, clang — required before Homebrew.
    if ! xcode-select -p &>/dev/null; then
        info "Installing Xcode Command Line Tools..."
        xcode-select --install
        # Wait for the install dialog to complete before continuing
        until xcode-select -p &>/dev/null; do sleep 5; done
        okay "Xcode CLT installed"
    else
        okay "Xcode CLT already installed"
    fi

    # Install Homebrew if absent.
    # Homebrew is the macOS package manager. We detect the correct prefix
    # for Apple Silicon (/opt/homebrew) vs Intel (/usr/local).
    if ! command -v brew &>/dev/null; then
        info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add brew to PATH for the remainder of this script.
        # The actual shell config handles this permanently via path.zsh.
        if is_arm; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            eval "$(/usr/local/bin/brew shellenv)"
        fi
        okay "Homebrew installed"
    else
        okay "Homebrew already installed"
    fi

elif is_linux; then

    # On Linux, ensure git and curl are present (most distros have them).
    # We use apt here; adjust or extend for dnf/pacman as needed.
    if command -v apt-get &>/dev/null; then
        info "Updating apt and installing prerequisites..."
        sudo apt-get update -qq
        sudo apt-get install -y git curl zsh build-essential
        okay "Linux prerequisites installed"
    else
        warn "Unsupported package manager — install git, curl, zsh manually"
    fi

fi

# ---------------------------------------------------------------------------
# Step 3: Install mise (runtime version manager)
# ---------------------------------------------------------------------------
# mise manages Go, Node, Python, Ruby, and other runtimes.
# Install via mise.run — NOT via Homebrew — per supply chain policy.

if ! command -v mise &>/dev/null; then
    info "Installing mise via mise.run..."
    curl https://mise.run | sh
    # Add mise to PATH for the remainder of this script so zdot setup
    # can use it if needed. The shell config activates it permanently.
    export PATH="$HOME/.local/bin:$PATH"
    okay "mise installed"
else
    okay "mise already installed"
fi

# ---------------------------------------------------------------------------
# Step 4: Make zdot executable and hand off
# ---------------------------------------------------------------------------

chmod +x "$DOTFILES_DIR/bin/zdot"

info "Handing off to zdot setup..."
"$DOTFILES_DIR/bin/zdot" setup

echo ""
okay "Bootstrap complete. Open a new terminal (or: exec zsh)."
