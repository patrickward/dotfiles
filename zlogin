# add git info to prompt
# via: http://briancarper.net/blog/570/git-info-in-your-zsh-prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr '%F{28}•'
zstyle ':vcs_info:*' unstagedstr '%F{11}•'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn
precmd() {
  if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
    zstyle ':vcs_info:*' formats ' [%F{green}%b%u%F{blue}]'
  } else {
    zstyle ':vcs_info:*' formats ' [%F{green}%b%u%F{red}•%F{blue}]'
  }
  vcs_info
}
setopt prompt_subst
PROMPT='%F{blue}%n@%m %c${vcs_info_msg_0_}%F{blue} %(?/%F{blue}/%F{red})%% %{$reset_color%}'

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# load from local home .bin path first
export PATH="$HOME/.bin:$PATH"
