# zsh/config/prompt.zsh
#
# Prompt configuration using Pure (https://github.com/sindresorhus/pure)
#
# Pure is a minimal, async-aware prompt that provides:
#   - Current directory (abbreviated)
#   - Git branch, dirty state, and ahead/behind counts (async — never blocks)
#   - Last command exit status (❯ turns red on non-zero exit)
#   - Execution time for slow commands
#
# Pure requires two files on fpath: `prompt_pure_setup` and `async`.
# This file looks for them in:
#   1. Homebrew (preferred — works on macOS and Linux)
#   2. A vendored copy at $DOTFILES/zsh/vendor/pure (manual fallback)
#   3. Built-in minimal prompt (last resort, with install instructions)
#
# Installation:
#   macOS:        brew install pure
#   Linux (brew): brew install pure
#   Linux (npm):  npm install --global pure-prompt
#   Manual:       see docs/prompt.md

# ---------------------------------------------------------------------------
# Locate Pure on fpath
#
# We must add Pure's directory to fpath *before* calling promptinit.
# promptinit scans fpath for files named prompt_*_setup to discover themes.
# ---------------------------------------------------------------------------
_pure_found=false

# 1. Homebrew — brew --prefix returns the correct prefix on macOS (arm64/x86_64)
#    and on Linux if Homebrew is installed there. We guard with command -v so we
#    don't pay the cost of a failed brew call on systems without it.
if command -v brew &>/dev/null; then
    _brew_fns="$(brew --prefix 2>/dev/null)/share/zsh/site-functions"
    if [[ -f "${_brew_fns}/prompt_pure_setup" ]]; then
        fpath=("$_brew_fns" $fpath)
        _pure_found=true
    fi
    unset _brew_fns
fi

# 2. Manually vendored copy
#    Populate by copying or symlinking from a Pure clone:
#      cp pure.zsh  $DOTFILES/zsh/vendor/pure/prompt_pure_setup
#      cp async.zsh $DOTFILES/zsh/vendor/pure/async
#    Or run: zdot setup pure  (once a topics/pure/setup.sh exists)
if [[ "$_pure_found" == false ]] && [[ -f "$DOTFILES/zsh/vendor/pure/prompt_pure_setup" ]]; then
    fpath=("$DOTFILES/zsh/vendor/pure" $fpath)
    _pure_found=true
fi

# ---------------------------------------------------------------------------
# Initialize the prompt
# ---------------------------------------------------------------------------
if [[ "$_pure_found" == true ]]; then

    autoload -Uz promptinit
    promptinit
    prompt pure

    # ---------------------------------------------------------------------------
    # Pure configuration via zstyle
    #
    # Pure exposes all its settings through zstyle. These must be set after
    # `prompt pure` to take effect. Run `prompt -h pure` to see all options.
    # ---------------------------------------------------------------------------

    # Uncomment to change the prompt symbol color:
    # zstyle ':prompt:pure:prompt:success' color magenta  # default: magenta
    # zstyle ':prompt:pure:prompt:error'   color red       # default: red

    # Uncomment to change the git colors:
    # zstyle ':prompt:pure:git:branch'     color cyan      # default: 242 (gray)
    # zstyle ':prompt:pure:git:dirty'      color 218       # default: 218 (light pink)

    # Uncomment to always show git remote status (ahead/behind counts):
    # zstyle ':prompt:pure:git:pull'       use-locking no  # may speed up slow networks

    # ---------------------------------------------------------------------------
    # RPROMPT note
    #
    # Pure manages RPROMPT itself (async git state, command execution time).
    # Setting RPROMPT directly here will be overwritten by Pure's precmd hook.
    #
    # To add persistent RPROMPT content (e.g., current arch on Apple Silicon),
    # register a precmd hook that appends *after* Pure's hook runs:
    #
    #   autoload -Uz add-zsh-hook
    #   _my_rprompt() { RPROMPT="${RPROMPT} %F{green}$(arch)%f" }
    #   add-zsh-hook precmd _my_rprompt
    #
    # Note: `arch` output differs by platform (arm64/x86_64 on macOS,
    # x86_64/aarch64 on Linux), so gate this with an is_macos check if needed.
    # ---------------------------------------------------------------------------

else

    # ---------------------------------------------------------------------------
    # Fallback: minimal built-in prompt
    #
    # This is intentionally simple — it's a signal that Pure isn't installed,
    # not a permanent prompt. The warning below tells you how to fix it.
    #
    # Prompt format: user@host ~/path ❯
    #   %n = username      %m = short hostname     %~ = path (~ abbreviated)
    #   %(?.color.color)   = green ❯ on success, red ❯ on non-zero exit
    # ---------------------------------------------------------------------------
    PROMPT='%F{cyan}%n@%m%f %F{blue}%~%f %(?.%F{green}.%F{red})❯%f '
    RPROMPT=''

    print -P "%F{yellow}prompt: Pure not found. Using fallback prompt.%f"
    print -P "%F{yellow}Install: brew install pure%f"
    print -P "%F{yellow}Manual:  see \$DOTFILES/docs/prompt.md%f"

fi

unset _pure_found
