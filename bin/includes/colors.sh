#!/usr/bin/env bash
DEFAULT_PADDING=50
export C_RED='\033[0;31m'
export C_GREEN='\033[0;32m'
export C_BLUE='\033[0;34m'
export C_ORANGE='\033[0;33m'
export C_PURPLE='\033[0;35m'
export C_NC='\033[0m'

_echo_with_color() {
  if [ "$#" -gt 2 ]; then
    pad=$([ "$#" == 4 ] && echo "$4" || echo "$DEFAULT_PADDING")
    printf "${1}%-${pad}s${C_NC}%s \n" "$2" "$3"
  else
    printf "${1}%-40s${C_NC}" "$2"
  fi
}

echo_red() {
  _echo_with_color "${C_RED}" "$@"
}

echo_green() {
  _echo_with_color "${C_GREEN}" "$@"
}

echo_blue() {
  _echo_with_color "${C_BLUE}" "$@"
}

echo_orange() {
  _echo_with_color "${C_ORANGE}" "$@"
}

echo_purple() {
  _echo_with_color "${C_PURPLE}" "$@"
}

