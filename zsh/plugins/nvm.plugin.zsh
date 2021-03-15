# nvm plugin frrom Oh My Zsh
#
# This plugin adds autocompletions for [nvm](https://github.com/nvm-sh/nvm) — a Node.js version manager.
# It also automatically sources nvm, so you don't need to do it manually in your `.zshrc`.
#
# To use it, add `nvm` to the plugins array of your zshrc file:
#
# ```zsh
# plugins=(... nvm)
# ```
#
# ## Settings
#
# If you installed nvm in a directory other than `$HOME/.nvm`, set and export `NVM_DIR` to be the directory
# where you installed nvm.
#
# These settings should go in your zshrc file, before Oh My Zsh is sourced:
#
# - **`NVM_HOMEBREW`**: if you installed nvm via Homebrew, in a directory other than `/usr/local/opt/nvm`, you
#   can set `NVM_HOMEBREW` to be the directory where you installed it.
#
#- **`NVM_LAZY`**: if you want the plugin to defer the load of nvm to speed-up the start of your zsh session,
#  set `NVM_LAZY` to `1`. This will use the `--no-use` parameter when loading nvm, and will create a function
#  for `node`, `npm` and `yarn`, so when you call either of these three, nvm will load with `nvm use default`.
#
# - **`NVM_AUTOLOAD`**: if `NVM_AUTOLOAD` is set to `1`, the plugin will automatically load a node version when
#   if finds a [`.nvmrc` file](https://github.com/nvm-sh/nvm#nvmrc) in the current working directory indicating
#   which node version to load.

# See https://github.com/nvm-sh/nvm#installation-and-update
if [[ -z "$NVM_DIR" ]]; then
  if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
  elif [[ -d "${XDG_CONFIG_HOME:-$HOME/.config}/nvm" ]]; then
    export NVM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvm"
  fi
fi

# Don't try to load nvm if command already available
which nvm &> /dev/null && return

if [[ -f "$NVM_DIR/nvm.sh" ]]; then
  # Load nvm if it exists in $NVM_DIR
  source "$NVM_DIR/nvm.sh" ${NVM_LAZY+"--no-use"}
else
  # Otherwise try to load nvm installed via Homebrew
  # User can set this if they have an unusual Homebrew setup
  NVM_HOMEBREW="${NVM_HOMEBREW:-/usr/local/opt/nvm}"
  # Load nvm from Homebrew location if it exists
  if [[ -f "$NVM_HOMEBREW/nvm.sh" ]]; then
    source "$NVM_HOMEBREW/nvm.sh" ${NVM_LAZY+"--no-use"}
  else
    # Exit the plugin if we couldn't find nvm
    return
  fi
fi

# Call nvm when first using node, npm or yarn
if (( $+NVM_LAZY )); then
  function node npm yarn {
    unfunction node npm yarn
    nvm use default
    command "$0" "$@"
  }
fi

# Autoload nvm when finding a .nvmrc file in the current directory
# Adapted from: https://github.com/nvm-sh/nvm#zsh
if (( $+NVM_AUTOLOAD )); then
  load-nvmrc() {
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [[ -n "$nvmrc_path" ]]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [[ "$nvmrc_node_version" = "N/A" ]]; then
        nvm install
      elif [[ "$nvmrc_node_version" != "$node_version" ]]; then
        nvm use
      fi
    elif [[ "$node_version" != "$(nvm version default)" ]]; then
      echo "Reverting to nvm default version"
      nvm use default
    fi
  }

  autoload -U add-zsh-hook
  add-zsh-hook chpwd load-nvmrc

  load-nvmrc
fi

# Load nvm bash completion
for nvm_completion in "$NVM_DIR/bash_completion" "$NVM_HOMEBREW/etc/bash_completion.d/nvm"; do
  if [[ -f "$nvm_completion" ]]; then
    # Load bashcompinit
    autoload -U +X bashcompinit && bashcompinit
    # Bypass compinit call in nvm bash completion script. See:
    # https://github.com/nvm-sh/nvm/blob/4436638/bash_completion#L86-L93
    ZSH_VERSION= source "$nvm_completion"
    break
  fi
done

unset NVM_HOMEBREW NVM_LAZY NVM_AUTOLOAD nvm_completion
