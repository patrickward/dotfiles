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

    ## October deployment
    alias ocsync="envoy run commit && git pull origin production"
    alias ocdeploy="git push origin master && envoy run deploy"

    export BROWSER='open'

    # Add MAMP paths as the default php (no longer used)
    # export PATH="/Applications/MAMP/bin/php/php5.3.27/bin:/Applications/MAMP/Library/bin:$PATH"
    # export PATH="/Applications/MAMP/bin/php/php5.4.19/bin:/Applications/MAMP/Library/bin:$PATH"
    # export PATH="/Applications/MAMP/bin/php/php5.5.3/bin:/Applications/MAMP/Library/bin:$PATH"

    # Python Path for use with Homebrew
    export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

    # Rbenv
    export RBENV_ROOT=/usr/local/var/rbenv
    if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

fi

# Add the ~/bin directory to path
export PATH="$HOME/bin:$PATH"

# Add the global composer vendor bin
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Add specific vendor bin components
export PATH="./vendor/bin:$PATH"

# Add the default editor
export EDITOR=vim

# Added for CPAN
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-bright.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

