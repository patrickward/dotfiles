#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Include stuff that should only be on this computer
if [[ -r ~/.localinclude ]]; then
    source ~/.localinclude
fi

# Customize to your needs...

# Aliases

alias whats-my-ip="curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+'"

# Macbook Specific Customization

if [[ "$OSTYPE" == darwin* ]]; then

    alias vm="ssh vagrant@127.0.0.1 -p 2222"
    alias magevm="cd ~/Code/mage2-vagrant-base && vagrant ssh"

    ## October deployment
    alias ocsync="envoy run commit && git pull origin production"
    alias ocdeploy="git push origin master && envoy run deploy"

    export BROWSER='open'

    # Python Path for use with Homebrew (NO LONGER USING PYTHON FROM HOMEBREW)
    # export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

    # Rbenv
    export RBENV_ROOT=/usr/local/var/rbenv
    if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

    # todo-cli
    export TODOTXT_DEFAULT_ACTION=ls
    alias t='todo.sh'
    alias ta='todo.sh add'
    alias tam='todo.sh addm'
    alias tat='todo.sh addto'
    alias td='todo.sh do'
    alias tp='todo.sh pri'
    alias tl='todo.sh ls'
    alias tlc='todo.sh listcon'
    alias tlp='todo.sh listpri'
    alias tlpj='todo.sh listproj'
    alias tls5='todo.sh ls @s5'
    alias tltw='todo.sh ls @tw'
    alias tlh='todo.sh ls @home'
    alias tls='todo.sh ls @school'

    # Show/hide hidden files in Finder
    alias showHiddenFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
    alias hideHiddenFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

    # Add GaTech aliases
    alias gtroot="cd ~/GT/Code"
    alias gtdocs="cd /Users/patrickward/Dropbox\ \(Personal\)/GT"

    # CS6200
    alias gt_ios_dir="cd ~/GT/Code/CS8803-02-TA-for-IOS"
    # alias start_bonnie_docker="docker run --interactive --tty -v `pwd`:'/root/gios' -v '$HOME/.bonnie':'/root/.bonnie/' -w '/root/gios' --entrypoint=/bin/bash gtomscs/os"
    export GIOS_GRADER_DIR="/Users/patrickward/GT/Code/CS8803-02-TA-for-IOS/gt-cs8803-02-graders"
    alias start_bonnie_docker="docker run --interactive --tty -v $GIOS_GRADER_DIR:'/root/gios' -v '$HOME/.bonnie':'/root/.bonnie/' -w '/root/gios' --entrypoint=/bin/bash gtomscs/os"

    # CS8803-GA
    alias gt_home_dir="cd ~/GT/Code/CS8803-GA"
    alias gadocs="cd ~/Dropbox\ \(Personal\)/GT/8803-GA"

    # CS6475-CP
    alias gt_cp_dir="cd ~/GT/Code/CS6475-CP"
    alias activateCompPhoto="source $HOME/anaconda/bin/activate CompPhoto"
    # Alias to go to CS6475-CompPhoto directory and start anaconda
    # Note: had to ensure the anaconda path was set properly as well to remove jupyter errors
    alias cplabs="export PATH="$HOME/anaconda/bin:$PATH" && cd ~/GT/Code/CS6475-CP/lab_exercises && activateCompPhoto && jupyter notebook"

    # CS6460
    alias gt_edtech_dir="$HOME/GT/Code/CS6460-EdTech"

    # Sensory 5 aliases
    export TTG_MAGENTO_ROOT="~/Code/magento-ee-2.1.8"
    alias mageroot="cd $TTG_MAGENTO_ROOT"
    alias ttgcode="cd $TTG_MAGENTO_ROOT/app/code/Toffeetogo"
    alias ttgdesign="cd $TTG_MAGENTO_ROOT/app/design/frontend/Toffeetogo"
    alias ttgvagrant="cd $HOME/Code/mage2-vagrant-base"

    # iterm plugin specific
    #
    # itermplot: https://github.com/daleroberts/itermplot
    alias init_itermplot="export MPLBACKEND=\"module://itermplot\"; export ITERMPLOT=rv"

    # Overrides
    alias cfd=cdf

fi

# Add the ~/bin directory to path
export PATH="$HOME/bin:$PATH"

# Add the global composer vendor bin
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Add specific vendor bin components
export PATH="./vendor/bin:$PATH"

# Add Rust's Cargo system
export PATH="$HOME/.cargo/bin:$PATH"

# Add the default editor
export EDITOR=vim

# Added for CPAN
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-bright.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# GlassFish
export GLASSFISH_HOME=/usr/local/opt/glassfish/libexec

# pyenv
# export PYENV_ROOT="$HOME/.pyenv"

# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
#   eval "$(pyenv virtualenv-init -)"
# fi

# Ensuring 7.1 PHP is first.
export PATH="/usr/local/opt/php@7.1/bin:$PATH"
export PATH="/usr/local/opt/php@7.1/sbin:$PATH"
# LDFLAGS:  -L/usr/local/opt/php@7.1/lib
# CPPFLAGS: -I/usr/local/opt/php@7.1/include


if [[ "$OSTYPE" == darwin* ]]; then
  # Add anaconda path
  # alias conda="~/anaconda/bin/conda"
  export PATH="/Users/patrickward/anaconda/bin:$PATH"
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Tmuxinator
source ~/.bin/tmuxinator.zsh
