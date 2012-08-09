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

It creates symlinks for all dotfiles in your home directory. You can safely run this file multiple times to update.

Included are zsh dotfiles. To switch your shell to zsh on OS X or Linux:

    chsh -s $(which zsh)

## Credits

- The install script is from [thoughtbot](https://github.com/thoughtbot/dotfiles).

## Copyright and License

I don't claim a copyright on any of these config files. Use it as you see fit.
However, some of the included scripts and plugins may have copyrights. So, see those
files and projects for details.


