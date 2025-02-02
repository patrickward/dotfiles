_not_inside_tmux() {
  [[ -z "$TMUX" ]]
}

ensure_tmux_is_running() {
  if [[ $ENSURE_TMUX_IS_RUNNING == 1 ]]; then
    if _not_inside_tmux; then
      if [[ -z "$INTELLIJ_ENVIRONMENT_READER" ]]; then
        read -r -s -k 1 "REPLY?Open a new Tmux session? "
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
          # tat is found in dotfiles/bin/tat
          tat
        fi
      fi
    fi
  fi
}

# _tmuxinator() {
#   local commands projects
#   commands=(${(f)"$(tmuxinator commands zsh)"})
#   projects=(${(f)"$(tmuxinator completions start)"})
#
#   if (( CURRENT == 2 )); then
#     _alternative \
#       'commands:: _describe -t commands "tmuxinator subcommands" commands' \
#       'projects:: _describe -t projects "tmuxinator projects" projects'
#   elif (( CURRENT == 3)); then
#     case $words[2] in
#       copy|debug|delete|open|start)
#         _arguments '*:projects:($projects)'
#       ;;
#     esac
#   fi
#
#   return
# }
#
# compdef _tmuxinator tmuxinator mux
# alias mux="tmuxinator"

# Local Variables:
# mode: Shell-Script
# sh-indentation: 2
# indent-tabs-mode: nil
# sh-basic-offset: 2
# End:
# vim: ft=zsh sw=2 ts=2 et

# source $HOME/.bin/tmuxinator.completion.zsh
#
