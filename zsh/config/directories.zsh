_dotfiles_directory_name () {

  # Ensuring we have a clean Zsh environment
  emulate -L zsh

  # Allowing the function to use extended glob characters
  setopt extendedglob

  local type=$1 name=$2 pattern=$3 dirpath=$4

  # Ensuring our variables are local to the function
  local -a match mbegin mend

  if [[ $type = n ]]; then

    [[ $name != (#b)$pattern:(?*) ]] && return 1
    typeset -ga reply
    reply=($HOME/code/$dirpath/$match[1])

  elif [[ $type = d ]]; then

    # turn the directory into a name
    if [[ $name = (#b)($HOME/code/$dirpath/)([^/]##)* ]]; then
      typeset -ga reply
      reply=($pattern:$match[2] $(( ${#match[1]} + ${#match[2]} )) )
    else
      return 1
    fi

  elif [[ $type = c ]]; then

    # Completions don't receive a 2nd argument,
    # so the pattern and dirpath are shifted back one position
    dirpath=$pattern
    pattern=$name

    # complete names
    local expl
    local -a dirs
    dirs=($HOME/code/$dirpath/*(/:t))
    dirs=($pattern:${^dirs})
    _wanted dynamic-dirs expl 'dynamic directory' compadd -S\] -a dirs
    return
  else
    return 1
  fi
  return 0
}

s5_directory_name () {
   _dotfiles_directory_name $1 $2 's' 's5'
   return $?
}

writing_directory_name () {
   _dotfiles_directory_name $1 $2 'w' 'writing'
   return $?
}

octetic_directory_name () {
   _dotfiles_directory_name $1 $2 'o' 'octetic'
   return $?

}

personal_directory_name () {
   _dotfiles_directory_name $1 $2 'p' 'personal'
   return $?
}

tw_directory_name () {
   _dotfiles_directory_name $1 $2 't' 'tw'
   return $?
}

# gt_directory_name () {
#    _dotfiles_directory_name $1 $2 'g' 'gt'
#    return $?
# }

circlez_directory_name () {
   _dotfiles_directory_name $1 $2 'c' 'circlez'
   return $?
}

learn_directory_name () {
   _dotfiles_directory_name $1 $2 'l' 'learn'
   return $?
}

zsh_directory_name_functions=(
  s5_directory_name
  # writing_directory_name
  octetic_directory_name
  # personal_directory_name
  # tw_directory_name
  # gt_directory_name
  circlez_directory_name
  # learn_directory_name
)


