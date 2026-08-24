# zsh/config/config.zsh
#
# Shell options, history, and key bindings.
# Loaded by zshrc.zsh for interactive shells only.
#
# Sections:
#   1. Color output
#   2. History
#   3. Completion behavior
#   4. Directory navigation
#   5. Prompt
#   6. Functions
#   7. Environment / misc
#   8. Key bindings
#   9. Vi mode (disabled by default)

# ---------------------------------------------------------------------------
# 1. Color output
#
# CLICOLOR=1 enables colorized ls output on macOS (equivalent to ls -G).
# LSCOLORS controls which color to use for each file type (macOS/BSD only).
# Linux uses LS_COLORS instead, which is set via dircolors.
#
# LSCOLORS format: 11 pairs of [fg][bg] characters, one pair per file type.
#
# Color codes:
#   a=black  b=red  c=green  d=brown  e=blue  f=magenta  g=cyan  h=lightgray
#   x=default terminal color   Uppercase = bold version of that color
#
# File type order (each pair in the string below):
#   1: directory          2: symbolic link      3: socket
#   4: pipe               5: executable         6: block device
#   7: character device   8: setuid exe         9: setgid exe
#   10: sticky+writable dir                     11: writable dir (no sticky)
# ---------------------------------------------------------------------------
export CLICOLOR=1
export LSCOLORS="exfxcxdxbxegedabagacad"  # macOS system default

# ---------------------------------------------------------------------------
# 2. History
#
# HISTFILE: where history is persisted on disk.
# HISTSIZE: maximum commands kept in memory per session.
# SAVEHIST: maximum commands written to HISTFILE.
#
# SHARE_HISTORY syncs history across all open sessions in real time.
# It implies INC_APPEND_HISTORY (write each command immediately) and
# APPEND_HISTORY (never overwrite the file), so setting all three is redundant.
#
# Trade-off: with SHARE_HISTORY on, commands typed in other open terminals
# will appear in this session's history search. This is usually desirable.
# ---------------------------------------------------------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt BANG_HIST               # Treat ! specially during expansion (!! for last command)
setopt EXTENDED_HISTORY        # Write history in ':start:elapsed;command' format
setopt SHARE_HISTORY           # Sync history across all open sessions in real time
setopt HIST_EXPIRE_DUPS_FIRST  # When trimming history, remove oldest duplicate first
setopt HIST_IGNORE_DUPS        # Don't record a command identical to the one just run
setopt HIST_IGNORE_ALL_DUPS    # When adding a duplicate, remove the older entry
setopt HIST_FIND_NO_DUPS       # Skip duplicate entries when searching (up-arrow, ^R)
setopt HIST_IGNORE_SPACE       # Don't record commands that begin with a space
setopt HIST_SAVE_NO_DUPS       # Don't write duplicate entries to HISTFILE
setopt HIST_VERIFY             # Show history expansion before executing (e.g. !!)

# ---------------------------------------------------------------------------
# 3. Completion behavior
# ---------------------------------------------------------------------------
setopt CORRECT                # Suggest spelling correction for mistyped commands
setopt COMPLETE_IN_WORD       # Complete from both ends of the cursor, not just end
setopt ALWAYS_TO_END          # Move cursor to end of word after any completion
setopt PATH_DIRS              # Perform path search for commands containing slashes
setopt AUTO_MENU              # Show completion menu on successive Tab presses
setopt AUTO_LIST              # List choices automatically on ambiguous completion
setopt AUTO_PARAM_SLASH       # When completing a directory, append a trailing slash
setopt EXTENDED_GLOB          # Enable extended glob patterns (^, #, ~) — required by compinit
setopt NO_MENU_COMPLETE       # Don't auto-select the first completion entry on Tab
setopt NO_FLOW_CONTROL        # Disable ctrl-s / ctrl-q flow control in the line editor
setopt COMPLETE_ALIASES       # Treat aliases as distinct commands for completion purposes

# ---------------------------------------------------------------------------
# 4. Directory navigation
# ---------------------------------------------------------------------------
setopt AUTO_CD                # Type a directory path alone to cd into it (no 'cd' needed)
setopt AUTO_PUSHD             # Every cd pushes the old directory onto the stack
setopt PUSHD_IGNORE_DUPS      # Don't push duplicate entries onto the directory stack
setopt PUSHD_SILENT           # Don't print the stack after pushd or popd
setopt PUSHD_TO_HOME          # pushd with no argument behaves like cd (goes to $HOME)
setopt CDABLE_VARS            # Allow cd to use a named variable as a directory path
setopt MULTIOS                # Allow multiple redirections: cmd > file1 > file2

# ---------------------------------------------------------------------------
# 5. Prompt
# ---------------------------------------------------------------------------
setopt PROMPT_SUBST           # Expand parameters, commands, and arithmetic in PROMPT
setopt TRANSIENT_RPROMPT      # Erase RPROMPT from all lines above the current prompt

# ---------------------------------------------------------------------------
# 6. Functions
# ---------------------------------------------------------------------------
setopt LOCAL_OPTIONS          # setopt changes inside a function don't leak out
setopt LOCAL_TRAPS            # trap changes inside a function don't leak out

# ---------------------------------------------------------------------------
# 7. Environment / misc
# ---------------------------------------------------------------------------
setopt NO_BEEP                # Never beep on errors or ambiguous completions
setopt COMBINING_CHARS        # Handle Unicode combining characters (accents) correctly
setopt INTERACTIVE_COMMENTS   # Allow # comments in an interactive shell
setopt RC_QUOTES              # Use '' to embed a literal quote: 'it''s fine'
setopt LONG_LIST_JOBS         # Print job details in long format by default (jobs -l)
setopt AUTO_RESUME            # Resume a matching suspended job instead of forking
setopt NOTIFY                 # Report job status changes immediately, not at next prompt
setopt NO_BG_NICE             # Don't lower the priority of background jobs
setopt NO_HUP                 # Don't send SIGHUP to running jobs when the shell exits

# ---------------------------------------------------------------------------
# 8. Key bindings
#
# These use escape sequences sent by macOS Terminal.app and iTerm2.
# If a binding doesn't work, run `cat -v` and press the key to see what
# escape sequence your terminal actually sends, then update the binding.
#
# Note: up/down arrow history search is registered in zshrc.zsh (after autoload).
# ---------------------------------------------------------------------------
bindkey '^[^[[D' backward-word       # Alt+Left  — move back one word
bindkey '^[^[[C' forward-word        # Alt+Right — move forward one word
bindkey '^[[5D'  beginning-of-line   # Ctrl+Left (some terminals)
bindkey '^[[5C'  end-of-line         # Ctrl+Right (some terminals)
bindkey '^[[3~'  delete-char         # Delete key — remove character under cursor
bindkey '^?'     backward-delete-char  # Backspace — remove character before cursor

# ---------------------------------------------------------------------------
# 9. Vi mode (disabled by default)
#
# Uncomment `bindkey -v` to switch the line editor to vi keybindings.
#
# Important: bindkey -v resets ALL bindings to vi defaults, which removes
# the emacs-style bindings many people rely on (^A/^E for start/end of line,
# ^R for reverse history search, etc.). The bindings in section 8 must also
# be re-applied after this line if you want to keep them.
#
# To enable vi mode, uncomment the line below and test your critical bindings.
# ---------------------------------------------------------------------------
# bindkey -v
