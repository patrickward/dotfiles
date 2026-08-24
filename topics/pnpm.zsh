# topics/pnpm.zsh
#
# pnpm: fast, disk space efficient package manager
# https://pnpm.io
# Install via: https://pnpm.io/installation

export PNPM_HOME="$HOME/Library/pnpm"
path=("$PNPM_HOME" $path)

alias p='pnpm'
alias pa='pnpm add'
alias pad='pnpm add --save-dev'
alias prm='pnpm remove'
alias prun='pnpm run'
