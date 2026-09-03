# topics/man/man.zsh
#
# Use bat as the man pager with proper roff stripping.
# "ansi" theme means bat defers color to the terminal palette (Ghostty).
# col -bx strips backspace-based bold/underline escape sequences groff emits.
# -p flag tells bat to act as a plain pager (no decorations, just color).
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Prevent bold/italic escape sequences from leaking (BSD man / groff).
export MANROFF_MODE=ps

# Stop man from wrapping at 80 cols on wide terminals.
export MANWIDTH=120
