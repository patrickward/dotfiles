# zsh/config/zshrc.zsh
#
# Loaded for INTERACTIVE shells only. Login check: use zprofile/zlogin.
#
# What goes here: completion, prompt, key bindings, plugins, functions.
# What does NOT go here: PATH (→ zshenv/path.zsh), aliases (→ aliases.zsh),
# environment variables (→ zshenv).
#
# Performance tip: to profile startup time, uncomment the zprof lines:
#   zmodload zsh/zprof    ← uncomment
#   ... (rest of file)
#   zprof                 ← add at bottom
# Then run: for i in $(seq 1 5); do /usr/bin/time zsh -i -c exit; done

# Load shell options, history, etc.
source "$DOTFILES/zsh/config/config.zsh"

# Load aliases
source "$DOTFILES/zsh/config/aliases.zsh"

# ---------------------------------------------------------------------------
# Topic files: flat files and topic directory files
#
# Flat:      topics/tool.zsh       — shell-config-only tools
# Directory: topics/tool/*.zsh     — tools with symlinks or setup.sh
#
# Exclusions:
#   path.zsh       → not used in new structure (PATH is in zsh/config/path.zsh)
#   completion.zsh → loaded after compinit below (order matters)
# ---------------------------------------------------------------------------
for file in "$DOTFILES"/topics/*.zsh(N); do
    source "$file"
done

for file in "$DOTFILES"/topics/*/*.zsh(N); do
    [[ "${file:t}" == path.zsh ]] && continue
    [[ "${file:t}" == completion.zsh ]] && continue
    source "$file"
done

# ---------------------------------------------------------------------------
# Completion system
#
# compinit scans $fpath for completion functions. We:
#   1. Add our functions dir to fpath (for custom completions like _brew, _run)
#   2. Only rebuild .zcompdump if it's older than 20 hours (Nm-20 glob qualifier)
#      This avoids the ~0.3s compinit penalty on every shell start.
#   3. -i suppresses "insecure files" warnings (common with Homebrew completions)
# ---------------------------------------------------------------------------
fpath=("$DOTFILES/zsh/functions" $fpath)

# Autoload custom functions (skip completions, which start with _)
autoload -Uz $DOTFILES/zsh/functions/^_*(N.:t)

autoload -Uz compinit
local comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))
if (( $#comp_files )); then
    compinit -i -C  # -C: skip security check (already verified recently)
else
    compinit -i
fi
unset comp_files

# Load completion files (after compinit, so completions can register properly)
for file in "$DOTFILES"/topics/*/completion.zsh(N); do
    source "$file"
done

# ---------------------------------------------------------------------------
# Key bindings: history search with arrow keys
#
# Up/Down arrows search backward/forward through history matching the
# current line prefix. Much more useful than cycling blindly.
# ---------------------------------------------------------------------------
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# ---------------------------------------------------------------------------
# Prompt
# ---------------------------------------------------------------------------
source "$DOTFILES/zsh/config/prompt.zsh"

# ---------------------------------------------------------------------------
# Plugins (minimal — only what we explicitly control)
# ---------------------------------------------------------------------------
source "$DOTFILES/zsh/config/plugins.zsh"

# ---------------------------------------------------------------------------
# Directory shortcuts (cdpath, named directories)
# ---------------------------------------------------------------------------
source "$DOTFILES/zsh/config/directories.zsh"

# ---------------------------------------------------------------------------
# fzf: fuzzy finder shell integration
#
# fzf --zsh (v0.48+) replaces the old ~/.fzf.zsh approach. Falls back to
# the old file if an older version is installed.
# ---------------------------------------------------------------------------
if command -v fzf &>/dev/null; then
    if fzf --version 2>/dev/null | awk -F. '{exit !($1 > 0 || $2 >= 48)}'; then
        source <(fzf --zsh)
    elif [[ -f "$HOME/.fzf.zsh" ]]; then
        source "$HOME/.fzf.zsh"
    fi
fi

# ---------------------------------------------------------------------------
# Local machine config: loaded last so it can override anything above.
# This is also where Herd, company-specific tools, etc. should be injected
# rather than committed to the repo.
# ---------------------------------------------------------------------------
[[ -f "$HOME/.localrc" ]] && source "$HOME/.localrc"

# ---------------------------------------------------------------------------
# Interactive login shell greeting
# Only shown for login shells (not every new tmux pane, etc.)
# ---------------------------------------------------------------------------
if [[ -o login ]]; then
    echo "💡 Type 'quickref' to see custom commands and aliases"
fi
