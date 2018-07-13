# Check to see if rbenv exists in $commands
# and initialize if it does
if (( $+commands[rbenv] ))
then
  eval "$(rbenv init -)"
fi
