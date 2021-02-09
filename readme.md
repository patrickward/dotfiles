# zdot

Dotfiles and maintenance scripts for my various boxen

Simple rules:

1. Only files that end in `*.zsh` are loaded, unless specifically called
2. Files in `**/config/` directories are ignored and should be called individually
3. Topic files are found in `src/*`. Src files (i.e. topics) are other dotfiles outside of the Zsh configuration.
4. `.zshenv` will be symlinked to $HOME
5. Zsh configuration files are found in `zsh/config/*`
6. Files ending in ".symlink" will be symlinked as hidden files in the user's home (e.g. foo.symlink becomes ~/.foo)
7. Zsh files are loaded in the following order as part of the Zsh configuration:
   1. `.zshenv` is loaded, and includes:
      1. `zsh/config/path.zsh`
      2. All `src/**/path.zsh` files
      3. `zsh/config/config.zsh`
      4. `zsh/config/aliases.zsh`
      5. All `src/**/*.zsh` files, except for `path.zsh` and `completion.zsh` files
   2. `.zprofile` is loaded in a login session
   3. `.zshrc` is loaded for interactive shells, and includes:
      1. `zsh/config/completion.zsh`
      2. All `src/**/completion.zsh` files
      3. `zsh/config/prompt.zsh`
   4. `.zlogin` is loaded in a login session
   5. `.zlogout` is loaded on logout from a login session

## Initial setup

This will link all `symlink` files and run all `setup.sh` files within the `dotfiles/` directory.

```bash
zdot setup

# May need to run this with a fully qualified command the first time
/path/to/dotfiles/bin/zdot setup
```


## Installing software

This will run all `install.sh` files within the `dotfiles/` directory.

```bash
zdot install
```

## Updating software

This will run all `update.sh` files within the `dotfiles/` directory.

```bash
zdot update
```

