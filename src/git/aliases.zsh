# GTM and Git
alias gtpush='git push && git pushgtm'
alias gtpull='git pull && git fetchgtm'

# Some useful git aliases
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gcb='git copy-branch-name'
alias gcb='git checkout -b'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias gac='git add -A && git commit -m'
alias ge='git-edit-new'
alias gsync-dev='git co develop && git merge master && git push && git co master'

# Prune remote folders that no longer exist
alias grprune='git remote update origin --prune'

alias git_sync='git pull -r && git push'

alias gcr='gclient-report'

alias gu='git aa && git commit -m "Update" && git push'

# Override git commands
# to ensure pushgtm and fetchgtm are executed
#function _xgit() {
#
#  if [[ "$1" == "push" ]]; then
#    command git "$@" && git pushgtm
#  elif [[ "$1" == "pull" ]]; then
#    command git "$@" && git fetchgtm
#  else
#    command git "$@"
#  fi
#}
# alias git='_xgit'
