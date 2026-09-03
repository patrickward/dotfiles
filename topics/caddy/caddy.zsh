# topics/caddy/caddy.zsh
#
# Convenience helpers for the local Caddy dev proxy.

if command -v brew >/dev/null 2>&1; then
  export CADDYFILE="${CADDYFILE:-$(brew --prefix)/etc/Caddyfile}"
  export CADDY_SITES_DIR="${CADDY_SITES_DIR:-$(brew --prefix)/etc/caddy/sites}"
fi

# zref: Show the configured sites for caddy
caddy-sites() {
  if [[ ! -d "$CADDY_SITES_DIR" ]]; then
    echo "Caddy sites directory does not exist: $CADDY_SITES_DIR" >&2
    return 1
  fi

  local sites=("$CADDY_SITES_DIR"/*.caddy(N:t:r))

  if (( ${#sites[@]} == 0 )); then
    echo "No Caddy sites configured in $CADDY_SITES_DIR"
    return 0
  fi

  printf '%s\n' "${sites[@]}"
}

# zref: CD to the caddy sites directory
caddy-sites-cd() {
  cd "$CADDY_SITES_DIR"
}

# zref: Edit the main Caddyfile
caddy-edit() {
  ${EDITOR:-vi} "$CADDYFILE"
}

# zref: Edit a specific caddy file under the caddy/sites directory
caddy-site() {
  if [[ $# -lt 1 ]]; then
    echo "usage: caddy-site <name>" >&2
    echo "opens: \$CADDY_SITES_DIR/<name>.caddy" >&2
    return 2
  fi

  local name="${1%.caddy}"
  ${EDITOR:-vi} "$CADDY_SITES_DIR/${name}.caddy"
}

# zref: Format a specific caddy file (or leave empty and format all)
caddy-fmt() {
  if [[ $# -gt 0 ]]; then
    local name="${1%.caddy}"
    caddy fmt --overwrite "$CADDY_SITES_DIR/${name}.caddy"
  else
    caddy fmt --overwrite "$CADDYFILE"
    caddy fmt --overwrite "$CADDY_SITES_DIR"/*.caddy(N)
  fi
}

# zref: Validate the Caddyfile and imports are correct
caddy-check() {
  caddy validate --config "$CADDYFILE"
}

# zref: Reload the caddy server
caddy-reload() {
  caddy reload --config "$CADDYFILE"
}

# zref: Restart the caddy server
caddy-restart() {
  brew services restart caddy
}

