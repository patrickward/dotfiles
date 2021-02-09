#!/usr/bin/env bash

print_color () {
  declare -A colors=(
    ['info']="\033[00;34m"
    ['warn']="\033[00;33m"
    ['okay']="\033[00;32m"
    ['fail']="\033[00;31m"
  )
  default="\033[0m"
  color="${2:-info}"
  printf "\r%b%s%b\n" "${colors["$color"]}" "$1" "$default"
}

info () {
  print_color "$1" "info"
}

warn () {
  print_color "$1" "warn"
}

okay () {
  print_color "$1" "okay"
}

fail () {
  print_color "$1" "fail"
}

ask () {
  read -r -s -n 1 -p "$(print_color "$1" "warn")" REPLY
}

ask_long () {
  read -r -p "$(print_color "$1" "warn")" REPLY
}

# Original from https://github.com/holman/dotfiles
link_file () {

  local src=$1
  local dst=$2
  local overwrite=backup=skip=dst=REPLY=

  if [[ -f "$dst" || -d "$dst" || -L "$dst" ]]
  then

    if [[ -z $overwrite_all && -z $backup_all && -z $skip_all ]]
    then

      local currentSrc
      currentSrc="$(readlink "$dst")"

      if [[ "$currentSrc" == "$src" ]]
      then

        skip=true;

#      else
#
#        warn "File already exists: $dst ($(basename "$src")), what do you want to do?"
#        ask "[s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
#
#        case "$REPLY" in
#          o )
#            overwrite=true;;
#          O )
#            overwrite_all=true;;
#          b )
#            backup=true;;
#          B )
#            backup_all=true;;
#          s )
#            skip=true;;
#          S )
#            skip_all=true;;
#          * )
#            ;;
#        esac

      fi

    fi

#    overwrite=${overwrite:-$overwrite_all}
#    backup=${backup:-$backup_all}
#    skip=${skip:-$skip_all}

    if [[ "$skip" = true ]] || [[ "$LINK_FILE_BEHAVIOR" == "s" ]]
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

  if [[ "$skip" != true ]]  # false or empty
  then
    ln -s "$1" "$dst"
    okay "Linked $1 to $dst"
  fi

}

