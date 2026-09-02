# mdn  — search MDN Web Docs from the terminal
# cani — open caniuse.com for a feature (prints URL; -o opens browser)
#
# Dependencies: curl, jq
# Browser open: 'open' (macOS) or 'xdg-open' (Linux)

_dev_open_url() {
  if command -v open &>/dev/null; then
    open "$1"
  elif command -v xdg-open &>/dev/null; then
    xdg-open "$1"
  else
    echo "No browser opener found. Visit: $1" >&2
  fi
}

_dev_display() {
  if command -v bat &>/dev/null; then
    bat --style=plain --language=md
  else
    cat
  fi
}

# ------------------------------------------------------------------------------
# mdn <query> [-o] [-n <count>]
# ------------------------------------------------------------------------------
# Search MDN and print top results with summaries and URLs.
#   -o opens the top result in the browser.
#   -n <count> controls how many results to show (default: 5)
#
#   mdn "fetch api"
#   mdn "css grid" -o
#   mdn "web workers" -n 10
# ------------------------------------------------------------------------------
mdn() {
  local query="${1:?Usage: mdn <query> [-o] [-n <count>]}"
  local open_browser=0
  local count=5

  # Parse flags — shift past the query first
  shift
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -o) open_browser=1 ;;
      -n) count="${2:?-n requires a count}"; shift ;;
      *)  echo "Unknown option: $1" >&2; return 1 ;;
    esac
    shift
  done

  local encoded="${query// /+}"
  local api_url="https://developer.mozilla.org/api/v1/search?q=${encoded}&locale=en-US"

  if [[ $open_browser -eq 1 ]]; then
    local first_url
    first_url=$(curl -s -A "curl/dev-zsh" "$api_url" | jq -r '
      .documents[0].mdn_url // empty
      | "https://developer.mozilla.org" + .
    ')
    if [[ -n "$first_url" ]]; then
      echo "Opening: $first_url" >&2
      _dev_open_url "$first_url"
    else
      echo "No results found for '${query}'." >&2
      return 1
    fi
  else
    curl -s -A "curl/dev-zsh" "$api_url" | jq -r --argjson n "$count" '
      .documents[:$n][] |
      "## \(.title)\n   \(.summary)\n   https://developer.mozilla.org\(.mdn_url)\n"
    ' | _dev_display
  fi
}

# ------------------------------------------------------------------------------
# cani <feature> [-u]
# ------------------------------------------------------------------------------
# Opens caniuse.com in the browser by default.
#   -u prints the URL only, without opening the browser.
#
#   cani "css grid"
#   cani "webp"
#   cani "container queries" -u
# ------------------------------------------------------------------------------
cani() {
  local feature="${1:?Usage: cani <feature> [-u]}"
  local url_only=0
  [[ "${2:-}" == "-u" ]] && url_only=1

  local encoded="${feature// /+}"
  local url="https://caniuse.com/?search=${encoded}"

  if [[ $url_only -eq 1 ]]; then
    echo "$url"
  else
    echo "caniuse: $url" >&2
    _dev_open_url "$url"
  fi
}
