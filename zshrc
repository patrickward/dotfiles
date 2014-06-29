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

# Macbook Specific Customization

if [[ "$OSTYPE" == darwin* ]]; then
    export BROWSER='open'
    # Add MAMP paths as the default php
    export PATH="/Applications/MAMP/bin/php/php5.3.27/bin:/Applications/MAMP/Library/bin:$PATH"
fi

# Rbenv
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Add the default editor
export EDITOR=mvim
