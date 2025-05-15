# todo-cli
export TODOTXT_CONFIG='$DOTFILES/src/todo/todo.cfg'
export TODOTXT_DEFAULT_ACTION=ls
export TODOTXT_SORT_COMMAND='env LC_COLLATE=C sort -k 2,2 -k 1,1n'
# alias t="todo.sh -n -d $TODOTXT_CONFIG"

alias t="todo.sh -d $TODOTXT_CONFIG"
alias todo="todo.sh -d $TODOTXT_CONFIG"

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
tw() { todo_alias $@ "@work" }
th() { todo_alias $@ "@home"}
ts() { todo_alias $@ "@self"}
tg() { todo_alias $@ "@growth"}
twnext() { todo_alias $@ "@work" "@next" "-@assigned" }


