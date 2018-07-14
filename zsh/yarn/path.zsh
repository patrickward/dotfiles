# Yarn
# --------------------
# Add yarn global bin
# https://yarnpkg.com

# Lazy loading Yarn, so that the terminal can start up faster

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

__yarn_started=0

__yarn_init() {
  test $__yarn_started = 0 && {
    if (( $+commands[yarn] ))
    then
      export PATH="$PATH:`command yarn global bin`"
    fi
    __yarn_started=1
  }
}

yarn() {
  __yarn_init
  command yarn "$@"
}

