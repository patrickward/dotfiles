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

# Customize to your needs...

# Aliases

alias whats-my-ip="curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+'"
alias vm="ssh vagrant@127.0.0.1 -p 2222"

# Macbook Specific Customization

if [[ "$OSTYPE" == darwin* ]]; then
    export BROWSER='open'
    # Add MAMP paths as the default php
    # export PATH="/Applications/MAMP/bin/php/php5.3.27/bin:/Applications/MAMP/Library/bin:$PATH"
    # export PATH="/Applications/MAMP/bin/php/php5.4.19/bin:/Applications/MAMP/Library/bin:$PATH"
    export PATH="/Applications/MAMP/bin/php/php5.5.3/bin:/Applications/MAMP/Library/bin:$PATH"
fi

# Add the ~/bin directory to path
export PATH="$HOME/bin:$PATH"

# Add specific vendor bin components
export PATH="./vendor/bin:$PATH"

# Rbenv
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Add the default editor
export EDITOR=vim

# Added for CPAN
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
