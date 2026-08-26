#!/usr/bin/env bash
# topics/caddy/setup.sh
# Configure and start Caddy as a local HTTPS reverse proxy for *.test sites.
#
# Depends on:
#   - caddy installed via Brewfile (topics/homebrew/Brewfile)
#   - dnsmasq configured for *.test → 127.0.0.1 (topics/homebrew/setup.sh)

set -euo pipefail

is_macos || return 0

if ! command -v caddy &>/dev/null; then
  warn "caddy not found — run brew bundle first"
  return 1
fi

BREW_PREFIX="$(brew --prefix)"
CADDYFILE="${BREW_PREFIX}/etc/Caddyfile"
CADDY_SITES_DIR="${BREW_PREFIX}/etc/caddy/sites"
DOTFILES_CADDYFILE="${DOTFILES}/topics/caddy/Caddyfile"

# ---------------------------------------------------------------------------
# Install Caddyfile from dotfiles (substitute real brew prefix)
# ---------------------------------------------------------------------------
if [[ ! -f "$CADDYFILE" ]] || ! grep -qF "$CADDY_SITES_DIR" "$CADDYFILE" 2>/dev/null; then
  info "Installing Caddyfile to ${CADDYFILE}"
  sed "s|BREW_PREFIX|${BREW_PREFIX}|g" "$DOTFILES_CADDYFILE" > "$CADDYFILE"
else
  okay "Caddyfile already in place"
fi

# ---------------------------------------------------------------------------
# Create sites/ directory for per-project configs
# ---------------------------------------------------------------------------
if [[ ! -d "$CADDY_SITES_DIR" ]]; then
  info "Creating caddy sites directory: ${CADDY_SITES_DIR}"
  mkdir -p "$CADDY_SITES_DIR"
else
  okay "caddy sites directory exists"
fi

# ---------------------------------------------------------------------------
# Trust Caddy's local CA in the macOS Keychain (one-time; idempotent)
# Caddy auto-generates a CA on first run. After trusting it, browsers and
# curl accept *.test certs without warnings.
# ---------------------------------------------------------------------------
if ! security find-certificate -c "Caddy Local Authority" /Library/Keychains/System.keychain &>/dev/null; then
  info "Trusting Caddy's local CA (may prompt for password)"
  caddy trust
else
  okay "Caddy local CA already trusted"
fi

# ---------------------------------------------------------------------------
# Start caddy service
# ---------------------------------------------------------------------------
if ! brew services list | grep -q "caddy.*started"; then
  info "Starting caddy"
  brew services start caddy
else
  okay "caddy already running"
fi
