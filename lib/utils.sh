#!/usr/bin/env zsh
# shellcheck disable=SC2154
# For colors info see: https://unix.stackexchange.com/a/408871

join_by () {
  local IFS="$1"
  shift; echo "$*"
}

autoload colors; colors

info () {
  echo "${fg[blue]}$1$reset_color"
}

warn () {
  echo "${fg[yellow]}$1$reset_color"
}

okay () {
  echo "${fg[green]}$1$reset_color"
}

fail () {
  echo "${fg[red]}$1$reset_color"
}

asks () {
  # true is needed to ensure that a respone of "n"
  # does not return with a non-zero value and exit
  # read -r -s -q "REPLY?$(warn "$1")" || true
  read -r -s -k 1 "REPLY?$(warn "$1")"
  echo ""
}

askl () {
  read -r "REPLY?$(warn "$1") "
}

# Original from https://github.com/holman/dotfiles
link_file () {

  local src=$1
  local dst=$2

  if [[ -f "$dst" || -d "$dst" || -L "$dst" ]]
  then



    local currentSrc
    currentSrc="$(readlink "$dst")"

    if [[ "$currentSrc" == "$src" ]]
    then

      skip=true;

    fi

    if [[ "$skip" = true ]] || [[ $LINK_FILE_BEHAVIOR = "s" ]]
    then
      skip=true
      okay "Skipped $src"
    else

      if [[ "$LINK_FILE_BEHAVIOR" = "o" ]]
      then
        rm -rf "$dst"
        okay "Removed $dst"
      fi

      if [[ "$LINK_FILE_BEHAVIOR" = "b" ]]
      then
        mv "$dst" "${dst}.backup"
        okay "Moved $dst to ${dst}.backup"
      fi

    fi

  fi

  # Always add to the symlinks file
  echo "$dst" >> "$XDG_CONFIG_HOME/zdot/symlinks.txt"

  if [[ "$skip" != true ]]  # false or empty
  then
    ln -s "$1" "$dst"
    okay "Linked $1 to $dst"
  fi

}

# shellcheck disable=SC2034
#{
#  typeset -f -u info
#  typeset -f -u asks
#  typeset -f -u warn
#  typeset -f -u okay
#  typeset -f -u askl
#  typeset -f -u link_file
#}

