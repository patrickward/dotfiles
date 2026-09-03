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
# zref: mdn: Search MDN and print top results with summaries and URLs.
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
# zref: cani: Opens caniuse.com in the browser by default.
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

# ------------------------------------------------------------------------------
# goto [query] [-o] [-g]
# ------------------------------------------------------------------------------
# zref: goto: List and open bookmarks
#
# Opens from topics/dev/bookmarks (committed) and topics/dev/bookmarks.local (gitignored, optional).
#
#   goto                    List all bookmarks (sorted alphabetically)
#   goto -g                 List all bookmarks with section groups
#   goto <query>            Filter bookmarks by name/tag/description (sorted)
#   goto -g <query>         Filter bookmarks, preserving section groups
#   goto <query> -o         Open the matched URL in browser (first match)
#   goto -o <query>         Same — flag order doesn't matter
# ------------------------------------------------------------------------------

# Bookmark files — local extends/overrides committed set
_BM_FILE="${DOTFILES}/topics/dev/bookmarks"
_BM_LOCAL="${DOTFILES}/topics/dev/bookmarks.local"

goto() {
  local query=""
  local url_only=0
  local groups=0

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -u) url_only=1 ;;
      -g) groups=1 ;;
      *)  query="$1" ;;
    esac
    shift
  done

  _bm_all() {
    if [[ $groups -eq 1 ]]; then
      # Groups mode: keep comments and blank lines for visual grouping
      for f in "$_BM_FILE" "$_BM_LOCAL"; do
        [[ -f "$f" ]] && cat "$f"
      done
    else
      # Default: strip comments and blanks, then sort by tag
      for f in "$_BM_FILE" "$_BM_LOCAL"; do
        [[ -f "$f" ]] && grep -v '^\s*#' "$f" | grep -v '^\s*$'
      done | sort
    fi
  }

  local results
  if [[ -n "$query" ]]; then
    results=$(_bm_all | grep -i "$query")
  else
    results=$(_bm_all)
  fi

  if [[ -z "$results" ]]; then
    echo "No bookmarks found${query:+ matching '${query}'}." >&2
    return 1
  fi

  if [[ $url_only -eq 1 ]]; then
    # Print all matches — useful for piping or copying
    # Filter out comments/blanks even in groups mode
    echo "$results" | grep -v '^\s*#' | grep -v '^\s*$' | awk '{print $1, $2}'
  else
    local non_comment_results
    non_comment_results=$(echo "$results" | grep -v '^\s*#' | grep -v '^\s*$')
    local match_count
    match_count=$(echo "$non_comment_results" | wc -l | tr -d ' ')

    if [[ $match_count -eq 1 ]]; then
      # Single match — open it directly
      local url
      url=$(echo "$non_comment_results" | awk '{print $2}')
      echo "Opening: $url" >&2
      _dev_open_url "$url"
    else
      # Multiple matches — list them
      if [[ -n "$query" ]]; then
        echo "Multiple matches — narrow your query or use -u to list URLs:" >&2
      fi
      echo "$results" | awk '
        /^\s*#/ { print; next }
        /^\s*$/ { print; next }
        { printf "%-20s %-45s %s\n", $1, $2, substr($0, index($0,$3)) }
      ' | _dev_display
    fi
  fi
}

_goto_complete() {
  local -a tags

  # Pull tag column (field 1) from both bookmark files, strip comments/blanks
  tags=("${(@f)$(
    for f in "$_BM_FILE" "$_BM_LOCAL"; do
      [[ -f "$f" ]] && grep -v '^\s*#' "$f" | grep -v '^\s*$' | awk '{print $1}'
    done | sort
  )}")

  compadd -a tags
}

compdef _goto_complete goto
