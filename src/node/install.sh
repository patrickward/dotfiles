install_zsh_nvm () {
  if ! [[ -f "$HOME/.config/zsh-vm" ]]; then
    info "Installing zsh-nvm"
    git clone https://github.com/lukechilds/zsh-nvm.git ~/.config/zsh-nvm
  else
    info "Found existing zsh-nvm"
  fi
}

if ! command -v nvm &> /dev/null
then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
  install_zsh_nvm
else
  install_zsh_nvm
fi
