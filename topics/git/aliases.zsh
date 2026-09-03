# topics/git/aliases.zsh
#
# Shell-level git aliases (complement the aliases in gitconfig).
# gitconfig aliases are invoked as `git co`; these are standalone shortcuts.

alias gl='git pull --prune'                                    # zref: Pull with prune
alias gp='git push origin HEAD'                                # zref: Push current branch to origin
alias gb='git branch'                                          # zref: List branches
alias gc='git commit'                                          # zref: Commit
alias gca='git commit -a'                                      # zref: Commit all tracked changes
alias gco='git checkout'                                       # zref: Checkout branch/commit
alias gcb='git checkout -b'                                    # zref: Create and checkout new branch
alias gs='git status -sb'                                      # zref: Short status with branch info
alias gac='git add -A && git commit -m'                        # zref: Stage all and commit with message
alias gdm='git diff main'                                      # zref: Diff against main
alias git-sync='git pull -r && git push'                       # zref: Rebase-pull then push
alias git-remote-prune='git remote update origin --prune'      # zref: Prune stale remote branches
# zref: Pretty graph log
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
