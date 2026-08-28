# topics/caddy/caddy.zsh
#
# Convenience helpers for the local Caddy dev proxy.

if command -v brew >/dev/null 2>&1; then
  export CADDYFILE="${CADDYFILE:-$(brew --prefix)/etc/Caddyfile}"
  export CADDY_SITES_DIR="${CADDY_SITES_DIR:-$(brew --prefix)/etc/caddy/sites}"
fi

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

caddy-sites-cd() {
  cd "$CADDY_SITES_DIR"
}

caddy-edit() {
  ${EDITOR:-vi} "$CADDYFILE"
}

caddy-site() {
  if [[ $# -lt 1 ]]; then
    echo "usage: caddy-site <name>" >&2
    echo "opens: \$CADDY_SITES_DIR/<name>.caddy" >&2
    return 2
  fi

  local name="${1%.caddy}"
  ${EDITOR:-vi} "$CADDY_SITES_DIR/${name}.caddy"
}

caddy-fmt() {
  if [[ $# -gt 0 ]]; then
    local name="${1%.caddy}"
    caddy fmt --overwrite "$CADDY_SITES_DIR/${name}.caddy"
  else
    caddy fmt --overwrite "$CADDYFILE"
    caddy fmt --overwrite "$CADDY_SITES_DIR"/*.caddy(N)
  fi
}

caddy-check() {
  caddy validate --config "$CADDYFILE"
}

caddy-reload() {
  caddy reload --config "$CADDYFILE"
}

caddy-restart() {
  brew services restart caddy
}
