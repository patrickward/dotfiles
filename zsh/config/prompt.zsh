# set the prompt
# Using Pure from https://github.com/sindresorhus/pure
# Files: zsh/pure.sh, zsh/async.sh
autoload -U promptinit; promptinit

# Add precmd, so that a conda env can be seen prior to the `pure` prompt
# precmd() {
#     if [ ! -z "$CONDA_DEFAULT_ENV" ]; then
#         local condaenv
#         condaenv=`basename $CONDA_DEFAULT_ENV`
#         # Grey=242
#         PROMPT="%F{242}($condaenv)%f %(?.%F{magenta}.%F{red})❯%f "
#     fi
# }

prompt pure
RPROMPT="%F{green}$(arch)%f"
