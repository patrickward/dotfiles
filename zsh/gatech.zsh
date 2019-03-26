# GaTech Aliases

# Add GaTech aliases
alias gt-docs="cd /Users/patrickward/Dropbox\ \(Personal\)/GT"

# alias start_bonnie_docker="docker run --interactive --tty -v `pwd`:'/root/gios' -v '$HOME/.bonnie':'/root/.bonnie/' -w '/root/gios' --entrypoint=/bin/bash gtomscs/os"
# export GIOS_GRADER_DIR="$HOME/Code/gt/ios-cs6200/TA-ios-cs8803-02/gt-cs6200-graders"
export GIOS_GRADER_DIR="$HOME/Code/gt/ios-cs6200/projects/gt-cs6200-graders"

# alias gt-start-bonnie-docker="docker run --interactive --tty -v $GIOS_GRADER_DIR:'/root/gios' -v '$HOME/.bonnie':'/root/.bonnie/' -w '/root/gios' --entrypoint=/bin/bash gtomscs/os"
alias gt-start-bonnie-docker="docker run --interactive --tty --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $GIOS_GRADER_DIR:'/root/gios' -v '$HOME/.bonnie':'/root/.bonnie/' -w '/root/gios' --entrypoint=/bin/bash fsgeek/omscs6200"

export GRPC_EXPLORE_DIR="$HOME/Code/gt/ios-cs6200/grpc/grpc-exploration"
alias gt-start-grpc-docker="docker run --interactive --tty -v $GRPC_EXPLORE_DIR:'/root/grpc' -w '/root/grpc' --entrypoint=/bin/bash fsgeek/omscs6200"

# Note the use of "--cap-add=SYS_PTRACE and --security-opt seccomp=unconfined"
# to get past the following error: "ptrace operation not permitted"
export GIOS_PR4_DIR="$HOME/Code/gt/ios-cs6200/projects/pr4"
alias gt-start-pr4-docker="docker run --interactive --tty --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -v $GIOS_PR4_DIR:'/root/gios' -w '/root/gios' --entrypoint=/bin/bash fsgeek/omscs6200"

# CS6475-CP
# alias gt_cp_dir="cd $HOME/Code/gt/cp-cs6475"
# alias activateCompPhoto="source $HOME/anaconda/bin/activate CompPhoto"
# Alias to go to CS6475-CompPhoto directory and start anaconda
# Note: had to ensure the anaconda path was set properly as well to remove jupyter errors
# alias cplabs="export PATH="$HOME/anaconda/bin:$PATH" && cd $HOME/Code/gt/cp-cs6475/lab_exercises && activateCompPhoto && jupyter notebook"
