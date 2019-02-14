# ZSH specific aliases

# Reload the zshrc config
alias reload!='. ~/.zshrc'

# Start a new zsh with no configuration
alias zsh-noconfig='zsh -d -f'

# Show all setopt options and whether they are on or off
alias show-all-setopt='setopt KSH_OPTION_PRINT && setopt && unsetopt KSH_OPTION_PRINT'

# What's my ip
alias whats-my-ip="curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+'"

# Vagrant aliases
alias vgs='vagrant global-status'

# Directory listings
alias l='ls -1A'
alias la='ll -A'
alias lc='lt -c'
alias lk='ll -Sr'
alias ll='ls -lh'
alias lm='la | "$PAGER"'

# List hidden directory files
alias lhd='ls -ld .??*'

# No correct - prevent spell checks on these commands
alias ack='nocorrect ack'
alias cd='nocorrect cd'
alias cpi='nocorrect cp -i'
alias ebuild='nocorrect ebuild'
alias grep='nocorrect grep --color=auto'
alias heroku='nocorrect heroku'
alias lni='nocorrect ln -i'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir -p'
alias mvi='nocorrect mv -i'
alias mysql='nocorrect mysql'
alias rmi='nocorrect rm -i'

# todo-cli
export TODOTXT_CONFIG='$HOME/.dotfiles/todo/todo.cfg'
export TODOTXT_DEFAULT_ACTION=ls
# alias t="todo.sh -n -d $TODOTXT_CONFIG"
alias t="todo.sh -d $TODOTXT_CONFIG"

todo_alias() {
  if [[ -z "$1" ]]; then
    t ls
  elif [[ "$1" =~ "^(\+|\@).*" ]]; then
    t ls $@
  else
    [[ ! -z "$1" ]] && t $@
  fi
}

# alias tw="t ls +Work"
tw() { todo_alias $@ "+Work" }
twnext() { todo_alias $@ "+Work" "@next" "-@assigned" }
tg() { todo_alias $@ "+GaTech" }
th() { todo_alias $@ "+Home" }
tl() { todo_alias $@ "+Life" }
ts() { todo_alias $@ "+Shopping" }

# GTM and Git
alias gtpush='git push && git pushgtm'
alias gtpull='git pull && git fetchgtm'

# Dropbox paths
export DROPBOX_PERSONAL="$HOME/Dropbox (Personal)"
export DROPBOX_WORK="$HOME/Dropbox (Sensory 5)"
alias dbp='cd "$DROPBOX_PERSONAL"'
alias dbw='cd "$DROPBOX_WORK"'

# Marked2
alias marked='open -a "Marked 2"'

