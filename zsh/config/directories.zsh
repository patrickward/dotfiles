# zsh/config/directories.zsh
#
# Directory navigation helpers: cdpath and named directory shortcuts.
# Loaded by zshrc.zsh after completions.
#
# See also: config.zsh sets AUTO_CD, AUTO_PUSHD, PUSHD_IGNORE_DUPS, and
# CDABLE_VARS — those options are what make the patterns below work well.

# ---------------------------------------------------------------------------
# cdpath — search path for cd
#
# Works like PATH but for the cd command. When you type `cd foo` and `foo`
# doesn't exist in the current directory, zsh searches cdpath directories
# for a match. Lets you jump to common project roots by short name.
#
# Example: with ~/code in cdpath, `cd dotfiles-v2` goes to ~/code/dotfiles-v2
# from anywhere.
#
# typeset -U cdpath deduplicates automatically (same as typeset -U path).
# ---------------------------------------------------------------------------
typeset -U cdpath
cdpath=(
    $HOME/code
    $cdpath
)

# ---------------------------------------------------------------------------
# Named directory functions (reference example — commented out)
#
# zsh supports "dynamic named directories" via zsh_directory_name_functions.
# They let you type `~prefix:name` as shorthand for a full path, with tab
# completion for the name part.
#
# Example: with the function below registered, typing `cd ~c:dotfiles-v2`
# would go to ~/code/dotfiles-v2, and `~c:<Tab>` would complete project names.
#
# This is more powerful than cdpath (supports arbitrary nesting, completion),
# but more complex to set up and rarely necessary if cdpath covers your use.
#
# To activate: define a function following this pattern and add its name to
# zsh_directory_name_functions, then uncomment the array registration.
#
# _code_directory_name() {
#     # $1 = operation: 'n' (name→path), 'd' (path→name), 'c' (complete)
#     # $2 = the name or path being resolved
#     # $3 = the prefix character (e.g., 'c')
#     # $4 = the base directory under $HOME/code (e.g., '')
#     emulate -L zsh
#     setopt extendedglob
#
#     local type=$1 name=$2 prefix=$3 basedir=$4
#     local -a match mbegin mend reply
#
#     if [[ $type = n ]]; then
#         # Resolve ~prefix:name → full path
#         [[ $name != (#b)${prefix}:(?*) ]] && return 1
#         reply=($HOME/code/$basedir/$match[1])
#
#     elif [[ $type = d ]]; then
#         # Resolve full path → ~prefix:name (for prompt display)
#         if [[ $name = (#b)($HOME/code/$basedir/)([^/]##)* ]]; then
#             reply=(${prefix}:$match[2] $(( ${#match[1]} + ${#match[2]} )))
#         else
#             return 1
#         fi
#
#     elif [[ $type = c ]]; then
#         # Provide tab completions for ~prefix:<Tab>
#         prefix=$name; basedir=$type
#         local expl
#         local -a dirs
#         dirs=($HOME/code/$basedir/*(/:t))
#         dirs=(${prefix}:${^dirs})
#         _wanted dynamic-dirs expl 'dynamic directory' compadd -S\] -a dirs
#     fi
#     return 0
# }
#
# # Register the function and choose a prefix letter
# # `~c:reponame` → ~/code/reponame
# # _myproject_directory_name() { _code_directory_name $@ 'c' ''; }
#
# zsh_directory_name_functions=(
#     # _myproject_directory_name
# )
