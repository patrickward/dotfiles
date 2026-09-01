# topics/cheat/cheat.zsh
#
# cheat: display a local cheatsheet, or fall back to cheat.sh for remote lookup.
# Requires: curl (remote), bat (optional, for display), $DOTFILES set.
#
# If $CHEAT_DIR is not found, uses $DOTFILES/topics.
#
# Usage:
#   cheat <topic>             Show local cheatsheet, or remote if not found
#   cheat                     List all local cheatsheets
#   cheat -e <topic>          Edit / create a local cheatsheet
#   cheat -r <topic>          Force remote lookup via cheat.sh
#   cheat -r <topic> <query>  Search within a topic remotely (e.g. cheat -r git rebase)
#   cheat -s <keyword>        Search cheat.sh across all sheets for a keyword
#   cheat -l <lang> <query>   Language cheatsheet (e.g. cheat -l python lambda)

export CHEAT_DIR="${DOTFILES}/topics"

cheat() {
  local cheat_dir="${CHEAT_DIR}"
  # local base_url="https://cht.sh"
  local base_url="cht.sh"

  # ---- Helpers ---------------------------------------------------------------

  _cheat_display_local() {
    local file="$1"
    if command -v bat &>/dev/null; then
      bat --style=plain --language=md "$file"
    else
      cat "$file"
    fi
  }

  _cheat_display_remote() {
    local url="$1"
    if command -v bat &>/dev/null; then
      curl -s -A "curl/cheat-zsh" "${url}?T" | bat --style=plain --language=md
    else
      curl -s -A "curl/cheat-zsh" "${url}"
    fi
  }

  # ---- No args: list local cheatsheets ---------------------------------------

  if [[ $# -eq 0 ]]; then
    echo "Local cheatsheets:"
    find "$cheat_dir" -name "*.cheat" | while read -r f; do
      basename "$(dirname "$f")"
    done | sort
    return 0
  fi

  # ---- Flags -----------------------------------------------------------------

  case "$1" in

    -e)
      # Edit / create a local cheatsheet
      local topic="${2:?Usage: cheat -e <topic>}"
      local target="${cheat_dir}/${topic}/${topic}.cheat"
      mkdir -p "$(dirname "$target")"
      ${EDITOR:-vim} "$target"
      return 0
      ;;

    -r)
      # Force remote lookup — optional sub-query as second arg
      # cheat -r tar
      # cheat -r git rebase
      local topic="${2:?Usage: cheat -r <topic> [query]}"
      local query="${3:-}"
      if [[ -n "$query" ]]; then
        _cheat_display_remote "${base_url}/${topic}/${query}"
      else
        _cheat_display_remote "${base_url}/${topic}"
      fi
      return 0
      ;;

    -s)
      # Search across all cheat.sh sheets for a keyword
      # cheat -s "time zone"
      # cheat -s snapshot/r     (recursive, using cheat.sh ~ syntax)
      local keyword="${2:?Usage: cheat -s <keyword>}"
      _cheat_display_remote "${base_url}/~${keyword}"
      return 0
      ;;

    -l)
      # Language-specific cheatsheet
      # cheat -l python lambda
      # cheat -l go Pointers
      local lang="${2:?Usage: cheat -l <lang> <query>}"
      local query="${3:?Usage: cheat -l <lang> <query>}"
      _cheat_display_remote "${base_url}/${lang}/${query}"
      return 0
      ;;

  esac

  # ---- Default: local first, remote fallback ---------------------------------

  local topic="$1"
  local file="${cheat_dir}/${topic}/${topic}.cheat"

  if [[ -f "$file" ]]; then
    _cheat_display_local "$file"
  else
    echo "No local cheatsheet for '${topic}' — trying cheat.sh..." >&2
    _cheat_display_remote "${base_url}/${topic}"
  fi
}

# Tab completion — complete on local topic names
_cheat_complete() {
  local cheat_dir="${CHEAT_DIR}"
  local -a topics
  topics=("${(@f)$(find "$cheat_dir" -name "*.cheat" -exec dirname {} \; \
    | xargs -I{} basename {} | sort)}")
  compadd -a topics
}
compdef _cheat_complete cheat
