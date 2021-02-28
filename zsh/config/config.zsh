# Set options
# Original LSCOLORS
# export LSCOLORS="exfxcxdxbxegedabagacad"
# LSCOLORS for solarized theme
export LSCOLORS="exfxfeaeBxxehehbadacea"
export CLICOLOR=true

# Add functions directory to fpath
if [ -d "$DOTFILES/zsh/functions" ] && [ "$(ls -A $DOTFILES/zsh/functions)" ]; then
    fpath=("$DOTFILES"/zsh/functions $fpath)
    autoload -U "$DOTFILES"/zsh/functions/*(:t)
fi

# Add topic folders to fpath, so that they can
# add functions and completion scripts as needed
# fpath=($DOTFILES/zsh/src $fpath)
if [ -d "$DOTFILES/zsh/prompt" ] && [ "$(ls -A "$DOTFILES"/zsh/prompt)" ]; then
    fpath=("$DOTFILES"/zsh/prompt $fpath)
fi

HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

## - Completions
setopt CORRECT                    # Try to correct the spelling of commands
# setopt CORRECT_ALL              # Try to correct the spelling of arguments as well
setopt COMPLETE_IN_WORD           # Complete from both ends of a word.
setopt ALWAYS_TO_END              # Move cursor to the end of a completed word.
setopt PATH_DIRS                  # Perform path search even on command names with slashes.
setopt AUTO_MENU                  # Show completion menu on a successive tab press.
setopt AUTO_LIST                  # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH           # If completed parameter is a directory, add a trailing slash.
setopt EXTENDED_GLOB              # Needed for file modification glob modifiers with compinit
setopt NO_MENU_COMPLETE           # Do not autoselect the first completion entry.
setopt NO_FLOW_CONTROL            # Disable start/stop characters in shell editor.

## - Directory
setopt AUTO_CD                    # Auto changes to a directory without typing cd.
setopt AUTO_PUSHD                 # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS          # Do not store duplicates in the stack.
setopt PUSHD_SILENT               # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME              # Push to home directory when no argument is given.
setopt CDABLE_VARS                # Change directory to a path stored in a variable.
setopt MULTIOS                    # Write to multiple descriptors (perform implicit tees or cats when multiple redirections are allowed)
setopt EXTENDED_GLOB              # Use extended globbing syntax.

## - History
setopt APPEND_HISTORY             # Append session history to the history file (all sessions see it)
setopt BANG_HIST                  # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY           # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY         # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY              # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST     # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS           # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS       # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS          # Do not display a previously found event.
setopt HIST_IGNORE_SPACE          # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS          # Do not write a duplicate event to the history file.
setopt HIST_VERIFY                # Do not execute immediately upon history expansion.
setopt HIST_BEEP                  # Beep when accessing non-existent history.

## - Functions
setopt LOCAL_OPTIONS              # Allow functions to have local options
setopt LOCAL_TRAPS                # Allow functions to have local traps

## - Prompt
setopt PROMPT_SUBST               # Allow parameter exapansion, command substition, and arithmetic expansion in prompts
setopt TRANSIENT_RPROMPT          # Only show the right prompt on the current prompt

## - Environment
setopt NO_BEEP                    # Don\'t beep on error
setopt COMBINING_CHARS            # Combine zero-length punctuation characters (accents)
setopt INTERACTIVE_COMMENTS       # Enable comments in interactive shell.
setopt RC_QUOTES                  # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
setopt LONG_LIST_JOBS             # List jobs in the long format by default.
setopt AUTO_RESUME                # Attempt to resume existing job before creating a new process.
setopt NOTIFY                     # Report status of background jobs immediately.
setopt NO_BG_NICE                 # Don\'t run all background jobs at a lower priority.
setopt NO_HUP                     # Don\'t kill jobs on shell exit.
# setopt NO_CHECK_JOBS            # Don\'t report on jobs when shell exit.

# Don't expand aliases _before_ completion has finished
setopt COMPLETE_ALIASES

zle -N newtab

# Key bindings
bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char

# Set to vim mode
bindkey -v
