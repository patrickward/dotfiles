. "$DOTFILES/lib/utils.sh"

setup_gitconfig () {

  if [ -f "$HOME/.gitconfig.local" ]
  then
    mv "$HOME/.gitconfig.local" "$HOME/.gitconfig.local.bak"
    warn "Backup created at $HOME/.gitconfig.local.bak"
  fi

  info "Setting gitconfig.local"

  git_credential='cache'

  if [ "$(uname -s)" == "Darwin" ]
  then
    git_credential='osxkeychain'
  fi

   sed -e "s/AUTHORNAME/$AUTHORNAME/g" \
    -e "s/AUTHOREMAIL/$AUTHOREMAIL/g" \
    -e "s|DOTFILES|$DOTFILES|g" \
    -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" \
    "$DOTFILES/src/git/gitconfig.local.template" > "$HOME/.gitconfig.local"

  okay 'Gitconfig local created'
}

setup_gitconfig
