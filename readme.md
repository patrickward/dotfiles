Patrick Ward's Dotfiles
-----------------------

These are the config files I use to set up my Mac OSX and Linux systems. I'm currently only working with an Arch Linux system. If you'd like to see my previous Mac OSX files, check out the [macosx-dotfiles branch](https://github.com/patrickward/dotfiles/tree/macosx-dotfiles).

> As of January 2014, I've moved to using the [prezto](https://github.com/sorin-ionescu/prezto) configuration framework for Zsh. The files in this repo reflect that change and use prezto as the base.

## Installation:

Fork this repo on Github.

Clone your fork (replace `your-github-name` with your Github name).

    git clone git@github.com:your-github-name/dotfiles.git
    cd dotfiles

Run the installer.

    ./install.sh

This will create symlinks for all dotfiles in your home directory. You can safely run this file multiple times to update.

Install [Vundle](https://github.com/gmarik/vundle) for managing the vim plugins in vimrc.

    git clone https://github.com/gmarik/vundle.git vim/bundle/vundle

Launch vim, run :BundleInstall (or vim +BundleInstall +qall for CLI lovers)

Included are zsh dotfiles. To switch your shell to zsh on OS X or Linux:

    chsh -s $(which zsh)

## Credits

- The install script is from [thoughtbot](https://github.com/thoughtbot/dotfiles).

## Copyright and License

I don't claim a copyright on any of these config files. Use it as you see fit.
However, some of the included scripts and plugins may have copyrights. So, see those
files and projects for details.

## Vim

I use [Vundle](https://github.com/gmarik/vundle) for managing the vim plugins in vimrc.

### Current plugins

* [base16-vim](https://github.com/chriskempson/base16-vim)
* [vim-markdown](https://github.com/tpope/vim-markdown)
* [vim-surround](https://github.com/tpope/vim-surround)
* [vim-fugitive](https://github.com/tpope/vim-fugitive)
* [vim-ruby](https://github.com/vim-ruby/vim-ruby)
* [vim-ragtag](https://github.com/tpope/vim-ragtag)
* [vim-endwise](http://github.com/tpope/vim-endwise)
* [vim-unimpaired](https://github.com/tpope/vim-unimpaired)
* [vim-coffee-script](https://github.com/kchmck/vim-coffee-script)
* [mustache.vim](https://github.com/juvenn/mustache.vim)
* [tabular](https://github.com/godlygeek/tabular)
* [vim-preview](https://github.com/greyblake/vim-preview)
* [vim-less](https://github.com/groenewege/vim-less)
* [blade.vim](https://github.com/johnhamelink/blade.vim)
* [vim-css-color](https://github.com/skammer/vim-css-color.git)
* [bufexplorer](https://github.com/vim-scripts/bufexplorer.zip)
* [vim-commentary](https://github.com/tpope/vim-commentary)
* [ack.vim](https://github.com/mileszs/ack.vim)
* [Markdown Preview](https://gist.github.com/960015)
* [Vim VCL HIghlighting](https://github.com/smerrill/vcl-vim-plugin)
* [Vim Ansible Yaml](https://github.com/chase/vim-ansible-yaml)

### Disabled Plugins

* [vim-colors-solarized](https://github.com/altercation/vim-colors-solarized)
