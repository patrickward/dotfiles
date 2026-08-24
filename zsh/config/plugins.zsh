# zsh/config/plugins.zsh
#
# Plugin configuration. Loaded by zshrc.zsh after completions.
#
# Philosophy: minimal and vendored where possible. External plugins are a
# maintenance surface — each one is a version to track and a potential
# source of startup slowness or widget conflicts. We load what we use.
#
# Currently loaded:
#   - globalias  (vendored — no dependency)
#
# Optional (commented out):
#   - zsh-autosuggestions  (external, brew or vendored)

# ---------------------------------------------------------------------------
# globalias — expand aliases inline on Space
#
# GLOBALIAS_FILTER_VALUES lists aliases that should NOT expand on Space.
# Any alias name in this list will be kept as-is when you press Space.
# Any alias NOT in this list will expand to its full definition.
#
# Whether to include your ls aliases (l, la, ll) is a judgment call:
#   - Excluded from filter → `l<Space>` expands to `ls -lFh ` (you see the command)
#   - Included in filter   → `l<Space>` stays as `l ` (cleaner line, less noise)
# They're included here for a cleaner command line. Remove them to see expansions.
# ---------------------------------------------------------------------------
GLOBALIAS_FILTER_VALUES=(
    cd      # directory navigation
    cp      # file operations (nocorrect candidates — see aliases.zsh)
    ln
    man     # pager
    mkdir
    mv
    rm
    grep    # search
    l       # ls aliases — remove these entries to see full expansions on space
    la
    ll
    vim     # editor
)

source "$DOTFILES/zsh/plugins/globalias.zsh"

# ---------------------------------------------------------------------------
# zsh-autosuggestions (optional — disabled by default)
#
# Shows a grayed-out suggestion from history as you type. Press Right arrow
# or End to accept the suggestion.
#
# Trade-off: very convenient, but works against building command muscle memory.
# It offers the completion before you've had to recall it yourself.
# Enable it once you're confident in your recall, or on machines where
# speed matters more than practice.
#
# Installation:
#   macOS/Linux (brew):  brew install zsh-autosuggestions
#   Manual:              git clone https://github.com/zsh-users/zsh-autosuggestions \
#                          $DOTFILES/zsh/vendor/zsh-autosuggestions
#
# To enable: uncomment the block below.
# ---------------------------------------------------------------------------
# _load_autosuggestions() {
#     local _as_script
#
#     # 1. Homebrew (macOS or Linux)
#     if command -v brew &>/dev/null; then
#         _as_script="$(brew --prefix 2>/dev/null)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
#     fi
#
#     # 2. Manually vendored copy
#     if [[ -z "$_as_script" || ! -f "$_as_script" ]]; then
#         _as_script="$DOTFILES/zsh/vendor/zsh-autosuggestions/zsh-autosuggestions.zsh"
#     fi
#
#     if [[ -f "$_as_script" ]]; then
#         source "$_as_script"
#         # Suggestion strategy: history first, then completion fallback
#         ZSH_AUTOSUGGEST_STRATEGY=(history completion)
#         # Accept suggestion with Right arrow or End key
#         # Ctrl+Space accepts just the next word of the suggestion
#         bindkey '^ ' autosuggest-accept-word
#     else
#         print -P "%F{yellow}plugins: zsh-autosuggestions not found.%f"
#         print -P "%F{yellow}Install: brew install zsh-autosuggestions%f"
#     fi
# }
# _load_autosuggestions
# unfunction _load_autosuggestions

# ---------------------------------------------------------------------------
# Not included — and why
#
# zsh-syntax-highlighting / fast-syntax-highlighting
#   Colors your command line as you type (green = valid, red = unknown).
#   Excluded because:
#     - Must be sourced LAST among all plugins (order-sensitive)
#     - Known to cause subtle slowdowns on complex command lines
#     - Can interfere with other ZLE widgets (history search, globalias)
#     - The benefit (catching typos before Enter) is modest given CORRECT
#       already handles misspelled commands at execution time
#   If you want it: source it after this file in zshrc.zsh and test carefully.
#
# zsh-history-substring-search
#   Better up-arrow history search (matches anywhere in the line).
#   Excluded because zshrc.zsh already uses up-line-or-beginning-search,
#   which matches from the start of the line — sufficient for most use.
#   The substring version is external and the improvement is minor.
# ---------------------------------------------------------------------------
