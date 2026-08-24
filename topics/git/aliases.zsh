# topics/git/aliases.zsh
#
# Shell-level git aliases (complement the aliases in gitconfig).
# gitconfig aliases are invoked as `git co`; these are standalone shortcuts.

alias gl='git pull --prune'
alias gp='git push origin HEAD'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gs='git status -sb'
alias gac='git add -A && git commit -m'
alias gdm='git diff main'
alias git-sync='git pull -r && git push'
alias git-remote-prune='git remote update origin --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
