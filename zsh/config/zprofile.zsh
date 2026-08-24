# zsh/config/zprofile.zsh
#
# Loaded for LOGIN shells only, before zshrc.
# Load order: zshenv → zprofile → zshrc → zlogin
#
# PATH and Homebrew are already handled in zshenv (runs for all shells),
# so this file is for login-shell-specific setup: editors, locale, pager.
#
# Keep this file fast — it runs for every login shell (including ssh sessions).

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
