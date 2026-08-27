# zsh/config/zprofile.zsh
#
# Loaded for LOGIN shells only, before zshrc.
# Load order: zshenv → zprofile → zshrc → zlogin
#
# Keep this file fast — it runs for every login shell (including ssh sessions).

# ---------------------------------------------------------------------------
# PATH: re-establish precedence after macOS path_helper
#
# macOS runs /usr/libexec/path_helper in /etc/zprofile, which executes AFTER
# ~/.zshenv. path_helper reads /etc/paths and reorders PATH so system dirs
# (/usr/bin, /bin, etc.) come first — undoing the order we set in path.zsh.
#
# Re-sourcing path.zsh here (after path_helper) restores the intended order:
#   local bin → dotfiles bin → homebrew → system
#
# typeset -gU in zshenv handles deduplication, so no duplicate entries result.
# On Linux (no path_helper), this is a harmless no-op.
# ---------------------------------------------------------------------------
source "$DOTFILES/zsh/config/path.zsh"

# ---------------------------------------------------------------------------
# Editors
# ---------------------------------------------------------------------------
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

# ---------------------------------------------------------------------------
# Locale
# ---------------------------------------------------------------------------
[[ -z "$LANG" ]] && export LANG='en_US.UTF-8'

# ---------------------------------------------------------------------------
# Less
#
# -F  exit immediately if the content fits on one screen
# -g  highlight only the current search match (not all)
# -i  case-insensitive search unless the pattern has uppercase
# -M  show more detail in the prompt (line numbers, percentage)
# -R  pass through ANSI color escape sequences raw
# -S  chop long lines rather than wrapping
# -w  highlight the first new line after a page forward
# -X  don't clear the screen on exit (keeps output visible after less exits)
# -z-4 scroll by window height minus 4 lines
# ---------------------------------------------------------------------------
export LESS='-F -g -i -M -R -S -w -X -z-4'

if (( $#commands[(i)lesspipe(|.sh)] )); then
    export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
