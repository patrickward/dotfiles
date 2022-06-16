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
