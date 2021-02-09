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

