#!/usr/bin/env bash
# topics/homebrew/setup.sh
# Install Homebrew packages from Brewfile

set -euo pipefail

is_macos || return 0

if ! command -v brew &>/dev/null; then
    warn "Homebrew not found — skipping brew bundle"
    return 1
fi

info "Installing Homebrew packages from Brewfile..."
brew bundle --verbose --file="$DOTFILES/topics/homebrew/Brewfile"
okay "Homebrew packages installed"

# Post install
# Safe to run repeatedly (idempotent throughout)

BREW_PREFIX="$(brew --prefix)"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

# Cache brew list once — brew list is slow (~300ms per call)
_BREW_FORMULAE="$(brew list --formula -1 2>/dev/null)"
_BREW_CASKS="$(brew list --cask -1 2>/dev/null)"

is_installed() {
  echo "$_BREW_FORMULAE" | grep -qx "$1" ||
  echo "$_BREW_CASKS"    | grep -qx "$1"
}

command_exists() {
  command -v "$1" &>/dev/null
}

# ---------------------------------------------------------------------------
# bash — keg-only shell registration
# ---------------------------------------------------------------------------
if is_installed bash; then
  BREW_BASH="${BREW_PREFIX}/bin/bash"
  if [[ -x "$BREW_BASH" ]]; then
    if ! grep -qF "$BREW_BASH" /etc/shells; then
      info "Registering Homebrew bash in /etc/shells"
      echo "$BREW_BASH" | sudo tee -a /etc/shells
    else
      okay "Homebrew bash already in /etc/shells"
    fi
  fi
fi

# ---------------------------------------------------------------------------
# dnsmasq — config + launchd service
# ---------------------------------------------------------------------------
if is_installed dnsmasq; then
  DNSMASQ_CONF="${BREW_PREFIX}/etc/dnsmasq.conf"
  RESOLVER_DIR="/etc/resolver"
  RESOLVER_FILE="${RESOLVER_DIR}/test"

  # Idempotent config write — only append if not already present
  if ! grep -qF "address=/.test/127.0.0.1" "$DNSMASQ_CONF" 2>/dev/null; then
    info "Configuring dnsmasq for *.test → 127.0.0.1"
    echo "address=/.test/127.0.0.1" >> "$DNSMASQ_CONF"
  else
    okay "dnsmasq *.test config already present"
  fi

  # Resolver file (requires sudo)
  if [[ ! -f "$RESOLVER_FILE" ]]; then
    info "Creating /etc/resolver/test"
    sudo mkdir -p "$RESOLVER_DIR"
    echo "nameserver 127.0.0.1" | sudo tee "$RESOLVER_FILE" > /dev/null
  else
    okay "/etc/resolver/test already exists"
  fi

  # Register + start as system service (sudo = boot-time, not user login)
  if ! sudo brew services list | grep -q "dnsmasq.*started"; then
    info "Starting dnsmasq as system service"
    sudo brew services start dnsmasq
  else
    okay "dnsmasq already running"
  fi
fi

# ---------------------------------------------------------------------------
# php — start php-fpm for local dev (used by Caddy *.test sites)
# ---------------------------------------------------------------------------
if is_installed php; then
  if ! brew services list | grep -qE "^php\s+started"; then
    info "Starting php-fpm"
    brew services start php
  else
    okay "php-fpm already running"
  fi
fi

# ---------------------------------------------------------------------------
# mailpit — start as user service (no sudo needed; dev-only tool)
# ---------------------------------------------------------------------------
if is_installed mailpit; then
  if ! brew services list | grep -q "mailpit.*started"; then
    info "Starting mailpit"
    brew services start mailpit
  else
    okay "mailpit already running"
  fi
fi

# redis — intentionally NOT auto-started; run on demand:
#   brew services start redis   (to start)
#   brew services stop redis    (to stop)
#   redis-server                (foreground, one-off)

# ---------------------------------------------------------------------------
# git-lfs — requires one-time global install hook
# ---------------------------------------------------------------------------
if is_installed git-lfs; then
  if ! git config --global --get filter.lfs.clean &>/dev/null; then
    info "Installing git-lfs hooks"
    git lfs install
  else
    okay "git-lfs already configured"
  fi
fi

# ---------------------------------------------------------------------------
# fzf — shell integration (key bindings + completion)
# Homebrew installs the binary but does NOT wire shell integration.
# The install script writes ~/.fzf.bash and ~/.fzf.zsh; source them from
# your shell config (or dotfiles topic) to activate.
# ---------------------------------------------------------------------------
if is_installed fzf; then
  FZF_INSTALL="${BREW_PREFIX}/opt/fzf/install"
  if [[ -x "$FZF_INSTALL" ]] && [[ ! -f "${HOME}/.fzf.zsh" ]]; then
    info "Installing fzf shell integration"
    "$FZF_INSTALL" --no-update-rc --completion --key-bindings
  else
    okay "fzf shell integration already present"
  fi
fi

# ---------------------------------------------------------------------------
# gnupg — create default config dir if absent
# ---------------------------------------------------------------------------
if is_installed gnupg; then
  GPG_DIR="${GNUPGHOME:-${HOME}/.gnupg}"
  if [[ ! -d "$GPG_DIR" ]]; then
    info "Creating GnuPG home directory"
    mkdir -p "$GPG_DIR"
    chmod 700 "$GPG_DIR"
  else
    okay "GnuPG home directory exists"
  fi
fi

# ---------------------------------------------------------------------------
# gh — authenticate if not already
# ---------------------------------------------------------------------------
if command_exists gh; then
  if ! gh auth status &>/dev/null; then
    warn "GitHub CLI (gh) is not authenticated — run: gh auth login"
  else
    okay "gh already authenticated"
  fi
fi

# ---------------------------------------------------------------------------
# macOS-specific steps
# ---------------------------------------------------------------------------
if [[ "$(uname -s)" == "Darwin" ]]; then

  # Postgres.app — add psql to PATH via /etc/paths.d if Postgres.app is installed
  POSTGRESAPP_PSQL="/Applications/Postgres.app/Contents/Versions/latest/bin"
  PATHS_D_FILE="/etc/paths.d/postgresapp"
  if [[ -d "$POSTGRESAPP_PSQL" ]] && [[ ! -f "$PATHS_D_FILE" ]]; then
    info "Registering Postgres.app CLI tools in PATH"
    echo "$POSTGRESAPP_PSQL" | sudo tee "$PATHS_D_FILE" > /dev/null
  fi

  # karabiner-elements — needs /dev/input access; just warn if installed but
  # not configured (config comes from dotfiles)
  if is_installed karabiner-elements; then
    KARABINER_CONF="${HOME}/.config/karabiner/karabiner.json"
    if [[ ! -f "$KARABINER_CONF" ]]; then
      warn "karabiner-elements installed but no config found at ${KARABINER_CONF}"
      warn "Copy your karabiner.json from dotfiles"
    fi
  fi

  # orbstack — no post-install wiring needed; starts on login automatically
  # But warn if docker CLI isn't resolving to OrbStack
  if is_installed orbstack && command_exists docker; then
    if ! docker info &>/dev/null; then
      warn "OrbStack installed but Docker daemon not running — launch OrbStack.app first"
    else
      okay "Docker (OrbStack) is running"
    fi
  fi

fi

info "Post brew bundle complete."
