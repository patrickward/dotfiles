# Default Path
# --------------------
export PATH="$HOME/.bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$DOTFILES/bin:$PATH"

# MANPATH
# --------------------
# Set the manpath, but only if needed
# export MANPATH="/user/local/man:/usr/local/git/man:$MANPATH"

export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export LDFLAGS="-L/usr/local/opt/icu4c/lib"
export CPPFLAGS="-I/usr/local/opt/icu4c/include"
export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig"

