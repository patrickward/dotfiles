# topics/mise.zsh
#
# mise: universal runtime version manager (go, node, python, ruby, etc.)
# https://mise.jdx.dev
#
# Replaces asdf, nvm, rbenv, pyenv, etc.
# `mise activate` adds shims to PATH and sets up version-switching hooks.

if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi
