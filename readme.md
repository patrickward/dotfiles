Patrick Ward's Dotfiles
-----------------------

These are the config files I use to set up my Mac OSX and Linux systems. I'm currently only working with an Arch Linux system. If you'd like to see my previous Mac OSX files, check out the [macosx-dotfiles branch](https://github.com/patrickward/dotfiles/tree/macosx-dotfiles).

## Installation:

Fork this repo on Github.

Clone your fork (replace `your-github-name` with your Github name).

    git clone git@github.com:your-github-name/dotfiles.git
    cd dotfiles

Run the installer.

    ./install.sh

Update the submodules.

    git submodule init
    git submodule update

It creates symlinks for all dotfiles in your home directory. You can safely run this file multiple times to update.

Included are zsh dotfiles. To switch your shell to zsh on OS X or Linux:

    chsh -s $(which zsh)

## Credits

- The install script is from [thoughtbot](https://github.com/thoughtbot/dotfiles).

## Copyright and License

I don't claim a copyright on any of these config files. Use it as you see fit.
However, some of the included scripts and plugins may have copyrights. So, see those
files and projects for details.

## Vim

I use [pathogen](https://github.com/tpope/vim-pathogen) to manage vim plugins, adding each plugin as a submodule below the vim/bundle directory.


### Current plugins

* [vim-colors-solarized](https://github.com/altercation/vim-colors-solarized)
* [vim-markdown](https://github.com/tpope/vim-markdown)

* [vim-surround](https://github.com/tpope/vim-surround)
* [vim-fugitive](https://github.com/tpope/vim-fugitive)
* [vim-ruby](https://github.com/vim-ruby/vim-ruby)
* [bufexplorer](https://github.com/vim-scripts/bufexplorer.zip)
* [vim-ragtag](https://github.com/tpope/vim-ragtag)
* [vim-endwise](http://github.com/tpope/vim-endwise)
* [vim-coffee-script](https://github.com/kchmck/vim-coffee-script)
* [mustache.vim](https://github.com/juvenn/mustache.vim)
* [vim-unimpaired](https://github.com/tpope/vim-unimpaired)
* [tabular](https://github.com/godlygeek/tabular)
* [vim-preview](https://github.com/greyblake/vim-preview)
* [vim-less](https://github.com/groenewege/vim-less)
* [blade.vim](https://github.com/johnhamelink/blade.vim)
* [vim-css-color](https://github.com/skammer/vim-css-color.git)

### Vim submodules

#### Adding a submodule (example)

    cd ~/dotfiles
    git submodule add <PATH-TO-GIT-REPO> vim/bundle/<NAME-OF-REPO>
    git aa
    gc

#### Removing a Submodule (example)

1. Delete the relevant line from the .gitmodules file
2. Delete the relevant section from .git/config
3. Run 'git rm --cached <PATH_TO_SUBMODULE> (no trailing slash)
4. Commit and delete the now untracked submodule files.

(via [StackOverflow](http://stackoverflow.com/questions/1260748/how-do-i-remove-a-git-submodule))

#### Updating all Submodules

Run the following to update each of the submodules under the vim/bundles directory:

    git submodule foreach git pull origin master

