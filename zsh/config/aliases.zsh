# zsh/config/aliases.zsh
#
# Shell aliases for interactive use.
# Loaded by zshrc.zsh after config.zsh.
#
# Conventions:
#   - Grouped by purpose, lightest first
#   - One alias per line with a brief comment
#   - No external tool dependencies (uses plain ls, not eza/lsd/etc.)
#   - macOS-specific sections are gated and labeled

# ---------------------------------------------------------------------------
# Shell management
# ---------------------------------------------------------------------------
alias reload='exec zsh'          # zref: @zsh: Replace current shell with a fresh one (full reload)
alias zsh-noconfig='zsh -d -f'   # zref: @zsh: Start zsh with no config at all (for debugging)

# zref: @zsh: Show all zsh options and whether each is on or off
alias show-setopt='setopt KSH_OPTION_PRINT && setopt && unsetopt KSH_OPTION_PRINT'

# ---------------------------------------------------------------------------
# Directory listing
#
# Uses plain ls with BSD/macOS flags. No external dependencies.
#   -l: long format     -F: classify (appends / * @ to names)
#   -h: human-readable sizes           -A: include hidden (not . and ..)
#   -G: colorize output (macOS)        -t: sort by modification time
#   -S: sort by size                   -r: reverse sort order
# ---------------------------------------------------------------------------
alias l='ls -lFh'         # zref: @zsh: Long, classified, human-readable
alias la='ls -lFhA'       # zref: @zsh: Same as l, plus hidden files
alias ll='ls -lhG'        # zref: @zsh: Long, colorized (kept for muscle memory)
alias lt='ls -lth'        # zref: @zsh: Sort by modification time, newest first
alias lS='ls -lSh'        # zref: @zsh: Sort by size, largest first
alias lSr='ls -lShr'      # zref: @zsh: Sort by size, smallest first
alias lhd='ls -ld .??*'   # zref: @zsh: List hidden entries only (dot-files and dot-dirs)

# ---------------------------------------------------------------------------
# Directory navigation
#
# AUTO_PUSHD in config.zsh makes every cd push to the directory stack.
# Use `d` to list recent directories (numbered), then `cd -N` to jump to one.
# Example: `d` shows the list, `cd -2` goes to entry 2.
# ---------------------------------------------------------------------------
# zref: @zsh: Lists recent directories (numbered); then `cd -N` to jump to one
alias d='dirs -v | head -10'

# ---------------------------------------------------------------------------
# Terminal
# ---------------------------------------------------------------------------
alias stty-sane='stty sane'  # zref: @zsh: Reset terminal line discipline if it becomes garbled

# ---------------------------------------------------------------------------
# nocorrect — suppress CORRECT spell-checking for specific commands
#
# CORRECT is enabled in config.zsh. It prompts before running a corrected
# command, so it's safe — but some commands trigger annoying false positives
# (e.g., `mkdir foo` being "corrected" to `Mkdir foo`).
#
# Uncomment entries below if you find CORRECT interrupting a specific command.
# To disable CORRECT entirely, comment it out in config.zsh instead.
# ---------------------------------------------------------------------------
# alias cd='nocorrect cd'
# alias cp='nocorrect cp -i'
# alias grep='nocorrect grep --color=auto'
# alias ln='nocorrect ln -i'
# alias man='nocorrect man'
# alias mkdir='nocorrect mkdir -p'
# alias mv='nocorrect mv -i'
# alias rm='nocorrect rm -i'

