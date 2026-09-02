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
#   cheat -d <topic>          Force remote lookup and download to a .cheat file in the topic file.

# topics/cheat/cheat.zsh

export CHEAT_DIR="${DOTFILES}/topics"
export CHEAT_DOWNLOAD_DIR="${CHEAT_DIR}/cheat/downloads"

cheat() {
  local base_url="https://cht.sh"

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

  # ---- No args: list local cheatsheets + downloads --------------------------

  if [[ $# -eq 0 ]]; then
    echo "Local cheatsheets:"
    find "$CHEAT_DIR" -name "*.cheat" \
      ! -path "${CHEAT_DOWNLOAD_DIR}/*" | while read -r f; do
      basename "$(dirname "$f")"
    done | sort

    if [[ -d "$CHEAT_DOWNLOAD_DIR" ]]; then
      echo ""
      echo "Downloaded cheatsheets:"
      find "$CHEAT_DOWNLOAD_DIR" -maxdepth 1 -name "*.cheat" | while read -r f; do
        basename "$f" .cheat
      done | sort
    fi
    return 0
  fi

  # ---- Flags -----------------------------------------------------------------

  case "$1" in
    -h)
      # Show the cheat cheatsheet as a quick reference
      local helpfile="${CHEAT_DIR}/cheat/cheat.cheat"
      if [[ -f "$helpfile" ]]; then
        _cheat_display_local "$helpfile"
      else
        echo "No cheat cheatsheet found at ${helpfile}" >&2
        return 1
      fi
      return 0
      ;;

    -e)
      local topic="${2:?Usage: cheat -e <topic>}"
      local target="${CHEAT_DIR}/${topic}/${topic}.cheat"
      mkdir -p "$(dirname "$target")"
      ${EDITOR:-vim} "$target"
      return 0
      ;;

    -r)
      local topic="${2:?Usage: cheat -r <topic> [query]}"
      local query="${3:-}"
      if [[ -n "$query" ]]; then
        _cheat_display_remote "${base_url}/${topic}/${query}"
      else
        _cheat_display_remote "${base_url}/${topic}"
      fi
      return 0
      ;;

    -d)
      local topic="${2:?Usage: cheat -d <topic>}"
      local safe_name="${topic//\//_}"
      local target="${CHEAT_DOWNLOAD_DIR}/${safe_name}.cheat"

      mkdir -p "$CHEAT_DOWNLOAD_DIR"
      echo "Downloading ${base_url}/${topic} -> ${target}" >&2
      curl -s -A "curl/cheat-zsh" "${base_url}/${topic}?T" > "$target"

      if [[ $? -eq 0 && -s "$target" ]]; then
        echo "Saved. Use: cheat ${safe_name}" >&2
        _cheat_display_local "$target"
      else
        echo "Download failed or empty response." >&2
        rm -f "$target"
        return 1
      fi
      return 0
      ;;

    -m)
      # Restore all downloaded cheatsheets from the manifest
      local manifest="${CHEAT_DOWNLOAD_DIR}/.cheat-manifest"
      if [[ ! -f "$manifest" ]]; then
        echo "No manifest found at ${manifest}" >&2
        return 1
      fi
      grep -v '^\s*#' "$manifest" | grep -v '^\s*$' | while read -r topic; do
        echo "Downloading ${topic}..." >&2
        cheat -d "$topic"
      done
      return 0
      ;;

    -s)
      local keyword="${2:?Usage: cheat -s <keyword>}"
      _cheat_display_remote "${base_url}/~${keyword}"
      return 0
      ;;

  esac

  # ---- Default: local first, tealdeer second, remote last -------------------

  local topic="$1"

  # 1. Check standard topic location
  local file="${CHEAT_DIR}/${topic}/${topic}.cheat"
  if [[ -f "$file" ]]; then
    _cheat_display_local "$file"
    return 0
  fi

  # 2. Check downloads folder (flat, no subdir)
  local downloaded="${CHEAT_DOWNLOAD_DIR}/${topic}.cheat"
  if [[ -f "$downloaded" ]]; then
    _cheat_display_local "$downloaded"
    return 0
  fi

  # 3. Try tealdeer (offline capable)
  echo "No local cheatsheet. Trying tealdeer..."
  if command -v tldr &>/dev/null && tldr --quiet "$topic" 2>/dev/null; then
    return 0
  fi

  # 4. Fall back to remote
  echo "No local cheatsheet for '${topic}' — trying cheat.sh..." >&2
  _cheat_display_remote "${base_url}/${topic}"
}

# Tab completion
_cheat_complete() {
  local -a topics

  # Standard .cheat files (topic name = parent dir name)
  topics+=("${(@f)$(find "$CHEAT_DIR" -name "*.cheat" \
    ! -path "${CHEAT_DOWNLOAD_DIR}/*" \
    -exec dirname {} \; | xargs -I{} basename {} | sort)}")

  # Downloaded .cheat files (flat, filename = topic name)
  if [[ -d "$CHEAT_DOWNLOAD_DIR" ]]; then
    topics+=("${(@f)$(find "$CHEAT_DOWNLOAD_DIR" -maxdepth 1 -name "*.cheat" \
      | xargs -I{} basename {} .cheat | sort)}")
  fi

  compadd -a topics
}
compdef _cheat_complete cheat
