if [[ -f "$XDG_CONFIG_HOME/zsh-nvm/zsh-nvm.plugin.zsh" ]]; then
  export NVM_LAZY_LOAD=true
  export NVM_AUTO_USE=true
  source "$XDG_CONFIG_HOME/zsh-nvm/zsh-nvm.plugin.zsh"
fi
