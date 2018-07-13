# GaTech Aliases

# Add GaTech aliases
alias gt-code="cd ~/GT/Code"
alias gt-docs="cd /Users/patrickward/Dropbox\ \(Personal\)/GT"

# CS6200
alias gt-ios-dir="cd ~/GT/Code/CS8803-02-TA-for-IOS"

# alias start_bonnie_docker="docker run --interactive --tty -v `pwd`:'/root/gios' -v '$HOME/.bonnie':'/root/.bonnie/' -w '/root/gios' --entrypoint=/bin/bash gtomscs/os"
export GIOS_GRADER_DIR="/Users/patrickward/GT/Code/CS8803-02-TA-for-IOS/gt-cs8803-02-graders"
alias gt-start-bonnie-docker="docker run --interactive --tty -v $GIOS_GRADER_DIR:'/root/gios' -v '$HOME/.bonnie':'/root/.bonnie/' -w '/root/gios' --entrypoint=/bin/bash gtomscs/os"

# CS6475-CP
# alias gt_cp_dir="cd ~/GT/Code/CS6475-CP"
# alias activateCompPhoto="source $HOME/anaconda/bin/activate CompPhoto"
# Alias to go to CS6475-CompPhoto directory and start anaconda
# Note: had to ensure the anaconda path was set properly as well to remove jupyter errors
# alias cplabs="export PATH="$HOME/anaconda/bin:$PATH" && cd ~/GT/Code/CS6475-CP/lab_exercises && activateCompPhoto && jupyter notebook"

# CS6460
alias gt-edtech-dir="$HOME/GT/Code/CS6460-EdTech"
