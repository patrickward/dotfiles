# topics/ngrok/completion.zsh
#
# ngrok shell completion (loaded after compinit)

if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
fi
