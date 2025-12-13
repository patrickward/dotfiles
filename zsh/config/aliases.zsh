# ZSH specific aliases

# Reload the zshrc config
# shellcheck disable=SC2139
alias reload!=". \$DOTFILES/zsh/config/zshrc.zsh"

# Start a new zsh with no configuration
alias zsh-noconfig='zsh -d -f'

# Refresh zsh functions
alias zr=zsh-refresh

# Show all setopt options and whether they are on or off
alias show-all-setopt='setopt KSH_OPTION_PRINT && setopt && unsetopt KSH_OPTION_PRINT'

# Directory listings
# alias l='ls -1A'
alias l='ls -lFh'
alias la='ls -lFhA'
alias lc='lt -c'
alias lk='ll -Sr'
alias lm='la | "$PAGER"'
alias ll='ls -lhG'

# Expand to named directories
alias c='cd ~['

# Directory history
alias d='dirs -v | head -10'
# alias 1='cd -'
# alias 2='cd -2'
# alias 3='cd -3'
# alias 4='cd -4'
# alias 5='cd -5'
# alias 6='cd -6'
# alias 7='cd -7'
# alias 8='cd -8'
# alias 9='cd -9'

# What's my ip
alias whats-my-ip="curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+'"

# List hidden directory files
alias lhd='ls -ld .??*'

# STTY Sanity
alias stty-sane='stty sane'

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

# Ruby bundler commands
alias be="bundle exec"
alias fl="bundle exec fastlane"

# Architecture 
alias mzsh="arch -arm64 zsh"
alias izsh="USING_ARCH_X86_64=1 arch -x86_64 zsh"

# Rails shortcuts 
alias b="./bin/"
alias rr="./bin/rails"
alias spec="./bin/rails spec"

