# zsh/plugins/globalias.zsh
#
# Expands aliases inline when you press Space, so you always see the
# real command before it runs. Ctrl+Space inserts a literal space without
# expanding, for when you want to type an alias name as an argument.
#
# Source: adapted from the Oh My Zsh globalias plugin (MIT license).
# Vendored here to avoid the Oh My Zsh dependency.
#
# How it works:
#   - Space is rebound to the `globalias` widget defined below.
#   - The widget looks at the last word typed before the cursor.
#   - If that word is NOT in GLOBALIAS_FILTER_VALUES, it expands the alias.
#   - It then inserts a space as normal via `self-insert`.
#
# Parameter expansion notes (for reference):
#   ${(Az)LBUFFER}   Split the left buffer into words using shell parsing rules.
#                    (A) = result as array, (z) = split on shell word boundaries.
#   [-1]             Take the last element of that array (word before cursor).
#   [(Ie)$word]      Search the filter array for $word.
#                    (I) = return index of match (0 if not found), (e) = exact match.
#                    Result of 0 means the word was NOT found in the filter list.

globalias() {
    local word=${${(Az)LBUFFER}[-1]}
    if [[ $GLOBALIAS_FILTER_VALUES[(Ie)$word] -eq 0 ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle self-insert
}
zle -N globalias

# Space expands aliases in normal editing and vi-insert mode
bindkey -M emacs " " globalias
bindkey -M viins " " globalias

# Ctrl+Space inserts a literal space without expanding
bindkey -M emacs "^ " magic-space
bindkey -M viins "^ " magic-space

# Normal space during incremental history search (never expand there)
bindkey -M isearch " " magic-space
