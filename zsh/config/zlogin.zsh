# zsh/config/zlogin.zsh
#
# Loaded for LOGIN shells only, after zshrc.
# Load order: zshenv → zprofile → zshrc → zlogin
#
# Use this for tasks that must run after the interactive config is fully loaded:
#   - Startup agents (gpg-agent, ssh-agent)
#   - Post-login checks or notices
#   - Anything that depends on aliases or functions defined in zshrc
#
# Note: the interactive greeting lives in zshrc (guarded by `[[ -o login ]]`)
# so it works whether this file exists or not.

# ---------------------------------------------------------------------------
# Compile the completion dump in the background
#
# zcompile converts .zcompdump to .zcompdump.zwc (bytecode), which zsh loads
# faster on subsequent shell starts. Running it here (after zshrc has called
# compinit and written a fresh dump) means the compiled file is always current.
# The &! disowns the subshell so it doesn't block the login shell.
# ---------------------------------------------------------------------------
{
    zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
    if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
        zcompile "$zcompdump"
    fi
} &!
