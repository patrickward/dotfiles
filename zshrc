# Load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

# automatically enter directories without cd
setopt auto_cd

# use vim as an editor
export EDITOR=vim

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# use incremental search
bindkey "^R" history-incremental-search-backward

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# handy key bindings
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# expand functions in the prompt
setopt prompt_subst

# prompt
export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '

# history file
export HISTFILE=~/.history
# keep lots of history
export HISTSIZE=4096
# keep lots of saved history
export SAVEHIST=1000
# print elapsed time when more than 10 seconds
export REPORTTIME=10

# ignore duplicate history entries
setopt histignoredups
# add timestamps to history
setopt extended_history
# turn on spelling correction
setopt correct
setopt correct_all
# Append history
setopt append_history
setopt hist_reduce_blanks

# automatically push directories onto the stack
setopt auto_pushd
export dirstacksize=5

# enable extended globbing
setopt extended_glob

# load any local configs
if [ -f ~/.localrc ]; then
	source ~/.localrc
fi
