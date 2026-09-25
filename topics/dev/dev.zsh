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
# mdn <query> [-o] [-n <count>] [-h]
# ------------------------------------------------------------------------------
# zref: mdn: Search MDN and print top results with summaries and URLs.
#   -o opens the top result in the browser.
#   -n <count> controls how many results to show (default: 5)
#   -h shows help
#
#   mdn "fetch api"
#   mdn "css grid" -o
#   mdn "web workers" -n 10
#   mdn -h
# ------------------------------------------------------------------------------
mdn() {
  local query
  local open_browser=0
  local count=5

  # Help
  if [[ "$1" == -h || "$1" == --help ]]; then
    echo "Usage: mdn <query> [-o] [-n <count>] [-h]"
    echo ""
    echo "Search MDN Web Docs from the terminal"
    echo ""
    echo "Options:"
    echo "  -o              Open the top result in browser"
    echo "  -n <count>     Number of results to show (default: 5)"
    echo "  -h              Show this help message"
    echo ""
    echo "Examples:"
    echo "  mdn \"fetch api\""
    echo "  mdn \"css grid\" -o"
    echo "  mdn \"web workers\" -n 10"
    return 0
  fi

  query="${1:?Usage: mdn <query> [-o] [-n <count>]}"

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
# cani <feature> [-u] [-h]
# ------------------------------------------------------------------------------
# zref: cani: Opens caniuse.com in the browser by default.
#   -u prints the URL only, without opening the browser.
#   -h shows help
#
#   cani "css grid"
#   cani "webp"
#   cani "container queries" -u
#   cani -h
# ------------------------------------------------------------------------------
cani() {
  local feature
  local url_only=0

  # Help
  if [[ "$1" == -h || "$1" == --help ]]; then
    echo "Usage: cani <feature> [-u] [-h]"
    echo ""
    echo "Open caniuse.com for a feature"
    echo ""
    echo "Options:"
    echo "  -u              Print URL only, without opening browser"
    echo "  -h              Show this help message"
    echo ""
    echo "Examples:"
    echo "  cani \"css grid\""
    echo "  cani \"webp\""
    echo "  cani \"container queries\" -u"
    return 0
  fi

  feature="${1:?Usage: cani <feature> [-u]}"
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
# goto [query] [-o] [-g] [-c <category>] [-a] [-h]
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
#   goto -c <category>      Filter by category (e.g., -c lang, -c 01-lang)
#   goto -c lang -g         Show only 'lang' category with groups preserved
#   goto -a                 List all available categories
#   goto -h                 Show help
# ------------------------------------------------------------------------------

# Bookmark files — local extends/overrides committed set
_BM_FILE="${DOTFILES}/topics/dev/bookmarks"
_BM_LOCAL="${DOTFILES}/topics/dev/bookmarks.local"

# List all available categories
_bm_list_categories() {
  echo "Available categories:"
  grep -h '^# ---- [0-9]' "$_BM_FILE" "$_BM_LOCAL" 2>/dev/null | sed 's/^# ---- \([0-9][0-9]*-[a-z]*\):.*/  \1/' | sort -u
}

goto() {
  local query=""
  local url_only=0
  local groups=0
  local category=""
  local list_categories=0

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -u) url_only=1 ;;
      -g) groups=1 ;;
      -a) list_categories=1 ;;
      -c|--category)
        if [[ -n "${2:-}" && "$2" != -.* ]]; then
          category="$2"
          shift
        else
          echo "Error: -c/--category requires a category name" >&2
          return 1
        fi
        ;;
      --categories) list_categories=1 ;;
      -h|--help)
        echo "Usage: goto [query] [-o] [-g] [-c <category>] [-a] [-h]"
        echo ""
        echo "List and open bookmarks from topics/dev/bookmarks and topics/dev/bookmarks.local"
        echo ""
        echo "Options:"
        echo "  -o              Open the matched URL in browser (first match)"
        echo "  -g              Show bookmarks with section groups"
        echo "  -c <category>   Filter by category (e.g., lang, 01-lang)"
        echo "  -a              List all available categories"
        echo "  -u              Print URLs only (for piping)"
        echo "  -h              Show this help message"
        echo ""
        echo "Examples:"
        echo "  goto                    List all bookmarks"
        echo "  goto -a                 List all categories"
        echo "  goto -c lang            Show language bookmarks"
        echo "  goto -c lang rust      Search for rust in lang category"
        echo "  goto -c tools -g        Show tools with grouping"
        return 0
        ;;
      *)  query="$1" ;;
    esac
    shift
  done

  if [[ $list_categories -eq 1 ]]; then
    _bm_list_categories
    return 0
  fi

  _bm_all() {
    if [[ $groups -eq 1 ]]; then
      for f in "$_BM_FILE" "$_BM_LOCAL"; do
        [[ -f "$f" ]] && cat "$f"
      done
    else
      for f in "$_BM_FILE" "$_BM_LOCAL"; do
        [[ -f "$f" ]] && grep -v '^\s*#' "$f" | grep -v '^\s*$'
      done | sort
    fi
  }

  _bm_filter_category() {
    local cat="$1"
    awk -v cat="$cat" '
      /^# ---- [0-9]/ {
        match($0, /[0-9][0-9]*-[a-z]+/)
        header_cat = substr($0, RSTART, RLENGTH)
        in_cat = (header_cat == cat || index(header_cat, cat) > 0)
        next
      }
      in_cat { print }
    ' "$_BM_FILE" "$_BM_LOCAL" 2>/dev/null | grep -v '^\s*$'
  }

  local results
  
  if [[ -n "$category" ]]; then
    if [[ $groups -eq 1 ]]; then
      results=$(_bm_filter_category "$category")
    else
      results=$(_bm_filter_category "$category" | grep -v '^\s*#' | sort)
    fi
  elif [[ -n "$query" ]]; then
    results=$(_bm_all | grep -i "$query")
  else
    results=$(_bm_all)
  fi

  if [[ -z "$results" ]]; then
    echo "No bookmarks found${query:+ matching '${query}'}${category:+ in category '${category}'}." >&2
    return 1
  fi

  if [[ $url_only -eq 1 ]]; then
    echo "$results" | grep -v '^\s*#' | grep -v '^\s*$' | awk '{print $1, $2}'
  else
    local non_comment_results
    non_comment_results=$(echo "$results" | grep -v '^\s*#' | grep -v '^\s*$')
    local match_count
    match_count=$(echo "$non_comment_results" | wc -l | tr -d ' ')

    if [[ $match_count -eq 1 ]]; then
      local url
      url=$(echo "$non_comment_results" | awk '{print $2}')
      echo "Opening: $url" >&2
      _dev_open_url "$url"
    else
      if [[ -n "$query" || -n "$category" ]]; then
        echo "Multiple matches${query:+ matching '${query}'}${category:+ in category '${category}'} — narrow your query or use -u to list URLs:" >&2
      fi
      echo "$results" | awk '
        /^\s*#/ { print; next }
        /^\s*$/ { print; next }
        { 
          tag = $1
          url = $2
          $1 = $2 = ""
          desc = substr($0, 2)
          printf "%-20s %-45s %s\n", tag, url, desc
        }
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
