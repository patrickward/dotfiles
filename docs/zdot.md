# zdot

Dotfiles manager. Named `zdot` to avoid collision with the Graphviz `dot` binary.

## Commands

| Command                | Description                         |
|------------------------|-------------------------------------|
| `zdot setup [topic]`   | Symlink dotfiles, run setup scripts |
| `zdot setup --dry-run` | Preview without making changes      |
| `zdot setdown`         | Remove all tracked symlinks         |
| `zdot install`         | Run all `install.sh` scripts        |
| `zdot update`          | Run all `update.sh` scripts         |
| `zdot status`          | Verify tracked symlinks are intact  |

## How Symlinks Work

`zdot setup` finds all files matching `*.symlink` under `topics/` and links them:

```
topics/git/gitconfig.symlink  →  ~/.gitconfig
topics/git/gitignore.symlink  →  ~/.gitignore
```

The `~/.` prefix comes from stripping the `.symlink` extension and prepending `$HOME/.`.

Tracked symlinks are written to `$XDG_CONFIG_HOME/zdot/symlinks.txt`.  
`zdot setdown` reads this file to remove them cleanly.

## Conflict Resolution

When a target file already exists, `zdot setup` prompts once per run:

- `s` — skip (leave the existing file alone)
- `o` — overwrite (delete and replace with symlink)
- `b` — backup (rename to `*.backup`, create symlink)

## Dry Run

```sh
zdot setup --dry-run
# or
ZDOT_DRY_RUN=1 zdot setup
```

No files are created, moved, or deleted. Actions are printed to stdout.

## Adding a Topic

For a tool that only needs shell config (PATH, aliases, init):

```sh
touch topics/mytool.zsh    # PATH additions, aliases, tool init
```

For a tool that needs symlinked dotfiles or a setup script:

```sh
mkdir topics/mytool
touch topics/mytool/mytool.zsh     # aliases, env vars, init
touch topics/mytool/setup.sh       # optional: one-time setup
touch topics/mytool/config.symlink # optional: links to ~/.config
```

`zdot setup` picks up new topics automatically. No registration required.

## Setup Scripts

`setup.sh` scripts run in a subshell with `lib/utils.sh` sourced, so
`is_macos`, `is_linux`, `okay`, `warn`, etc. are available.

A failing `setup.sh` prints a warning and continues — it does not abort the
full setup.

## Environment Variables

| Variable           | Default                         | Description                        |
|--------------------|---------------------------------|------------------------------------|
| `DOTFILES`         | Resolved from bin/zdot location | Repo root                          |
| `ZDOT_DRY_RUN`     | `0`                             | Set to `1` to skip destructive ops |
| `ZDOT_CONFIG_HOME` | `$XDG_CONFIG_HOME/zdot`         | Where symlinks.txt is stored       |

## References

- zsh startup file load order: `man zsh`, section STARTUP/SHUTDOWN FILES
- XDG Base Directory Spec: <https://specifications.freedesktop.org/basedir-spec/latest/>
- `typeset -U` (unique arrays): `man zshbuiltins`
