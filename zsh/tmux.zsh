_not_inside_tmux() { [[ -z "$TMUX" ]] }

ensure_tmux_is_running() {
  if [[ $ENSURE_TMUX_IS_RUNNING == 1 ]]; then
    if _not_inside_tmux; then
      tat
    fi
  fi
}
