# Set the paths

# Yarn
# --------------------
# yarn path is in zsh/yarn/path.zsh

# Composer
# --------------------
# Add the global composer vendor bin
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Add specific vendor bin components
export PATH="./vendor/bin:$PATH"

# Rust
# --------------------
# Add Rust's Cargo system
export PATH="$HOME/.cargo/bin:$PATH"

# Perl
# --------------------
# Added for CPAN
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

# Python
# --------------------
# pyenv
# export PYENV_ROOT="$HOME/.pyenv"

# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
#   eval "$(pyenv virtualenv-init -)"
# fi

if [[ "$OSTYPE" == darwin* ]]; then

  # PHP
  # --------------------
  # Ensuring 7.1 PHP is first
  export PATH="/usr/local/opt/php@7.1/bin:$PATH"
  export PATH="/usr/local/opt/php@7.1/sbin:$PATH"
  # LDFLAGS:  -L/usr/local/opt/php@7.1/lib
  # CPPFLAGS: -I/usr/local/opt/php@7.1/include

  # Python/Anaconda
  # --------------------
  # Add anaconda path
  # alias conda="~/anaconda/bin/conda"
  export PATH="$HOME/anaconda/bin:$PATH"

fi

# PATH
# --------------------
export PATH="$HOME/.bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$DOTDIR/bin:$PATH"

# MANPATH
# --------------------
# Set the manpath, but only if needed
# export MANPATH="/user/local/man:/usr/local/git/man:$MANPATH"
