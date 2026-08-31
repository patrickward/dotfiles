<!-- topics/vim/README.md -->

# Vim setup

Minimal, no plugin manager, no AI, no IDE pretensions — JetBrains handles heavy lifting; this is for quick edits, git,
and terminal work across all Linux boxes.

## Other docs

See [`GRAMMAR.md`](./GRAMMAR.md) — the verb/motion/text-object mental model, for when muscle memory needs a jog.

See [`PLUGINS.md`](./PLUGINS.md) for a quick-reference on using each installed plugin (surround, commentary, 
unimpaired, fugitive, fzf, tmux-runner).

## Key bindings (leader = space)

| Map                       | Action                                                                    |
|---------------------------|---------------------------------------------------------------------------|
| `<leader>f`               | fzf: find files                                                           |
| `<leader>g`               | fzf: git files                                                            |
| `<leader>r`               | fzf: ripgrep search                                                       |
| `<leader>b`               | fzf: buffers                                                              |
| `<leader>gs`              | fugitive: status                                                          |
| `<leader>gd`              | fugitive: diff split                                                      |
| `<leader>gb`              | fugitive: blame                                                           |
| `<leader>vr`              | tmux-runner: open runner pane                                             |
| `<leader>vs`              | tmux-runner: send lines to runner                                         |
| `<leader>w` / `<leader>q` | save / quit                                                               |
| `Esc Esc`                 | clear search highlight                                                    |
| `:Ex`                     | built-in file browser (netrw), tree view                                  |
| `:grep {pattern}`         | ripgrep into quickfix (`:cnext`/`:cprev` to navigate, `:cdo` to edit all) |
| `%`                       | jump matching pair — extended to tags/if-else via `matchit`               |

## Non-default behaviors to remember

- **Large files (>5MB)**: syntax, undo, and swap auto-disable on open — if a
  buffer looks unhighlighted, that's why, not a bug.
- **Whitespace is visible by default** (`listchars`): `▸` = tab, `·` = trailing
  space. Not an artifact of a bad paste.
- **Clipboard**: only synced with the OS if vim was built `+clipboard`
  (`vim --version | grep clipboard`). On boxes without it, use `"+y`/`"+p`
  explicitly, or set an override in `~/.vimrc.local`.
- **Theme has no colors of its own** — it maps to the terminal's 16 ANSI
  slots. If it looks wrong, check Ghostty's active theme, not this repo.

## How it works

- `vimrc.symlink` → `~/.vimrc`
- `vim/` → `~/.vim` (whole directory symlinked, per dotfiles convention)
- Plugins are **plain git clones**, not submodules, not a plugin manager. Vim's native package loading (`:h packages`,
  Vim 8+) picks up anything under `~/.vim/pack/plugins/start/*` automatically — no `plug#begin()`, no bootstrap script.
- `vim/plugins.txt` is the manifest (url, ref, dest — whitespace-tolerant, any amount of spaces/tabs works).
- `vim/bin/install-plugins.sh` reads the manifest and clones/updates each plugin into `pack/plugins/start/`. Requires
  `$DOTFILES` to be set; runs as part of the main dotfiles install, after symlinks and env are up.
- Theme is `vim/colors/ansi16.vim` — maps syntax groups to the 16 base terminal colors only, so it re-themes for free
  whenever the Ghostty theme changes. No theme plugin, no hardcoded hex values.
- `~/.vimrc.local` is a **per-machine, untracked** override file, sourced at the end of `.vimrc` if present. Use it for
  host-specific quirks (e.g. missing `fzf`, no `+clipboard`). Template: `vim/vimrc.local.example`.

## Adding / updating a plugin

1. Add a line to `vim/plugins.txt`: `url  ref  dest`
2. Run `vim/bin/install-plugins.sh`
3. Run `:helptags ALL` in vim (or `vim -u NONE -c 'helptags ALL' -c q` headless)

To remove a plugin: delete its line from `plugins.txt` **and** its directory under `pack/plugins/start/` (the script
only adds/updates, never deletes).

I chose not to use a special plugin manager as I wanted to keep things simple. Instead, I rely on Vim's native package 
loading feature (`:h packages`, Vim 8+) to automatically pick up any plugins under `~/.vim/pack/plugins/start/*`. 
This means that I don't need to use a plugin manager like Vim-Plug or Pathogen.

## Regenerating plugins from scratch

```bash
git rm -r --cached vim/pack/plugins/start  # only needed if git ever re-tracked them
rm -rf vim/pack/plugins/start/*
vim/bin/install-plugins.sh
```

`pack/plugins/start/` is fully disposable — nothing under it is ever committed
(see `.gitignore`); it's always rebuilt from `plugins.txt`.

## Troubleshooting

| Symptom                                                                        | Fix                                                                                                                                                                                                                 |
|--------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Plugin commands not found (`E492: Not an editor command`)                      | Run `install-plugins.sh`; confirm `$DOTFILES` is set and the plugin dir exists under `pack/plugins/start/`                                                                                                          |
| `:help` on a plugin topic fails (`E149`)                                       | Run `:helptags ALL`                                                                                                                                                                                                 |
| Colors look wrong / washed out                                                 | Ensure `notermguicolors` is set and your terminal (Ghostty) actually has a theme active — `ansi16.vim` has no colors of its own, it's 100% terminal-palette-driven                                                  |
| `<leader>f` / `<leader>r` (fzf/rg) do nothing                                  | Confirm `fzf` and `rg` are on `$PATH` on this box; if not yet installed, disable those maps in `~/.vimrc.local`                                                                                                     |
| `fzf` commands error with `E117: Unknown function: fzf#shellescape` or similar | `fzf.vim` needs the base `junegunn/fzf` repo installed *as a vim plugin* too (provides `fzf#run` API) — having the `fzf` binary on `$PATH` is not sufficient. Confirm both `fzf` and `fzf.vim` are in `plugins.txt` |
| Yank/paste doesn't sync with OS clipboard                                      | Check `vim --version \| grep clipboard` — needs `+clipboard` (e.g. `vim-gtk3` on Debian/Ubuntu, not plain `vim`). Headless/SSH boxes may never have this; use `"+y`/`"+p` explicitly there                          |
| `install-plugins.sh` errors with "DOTFILES env var not set"                    | Source your dotfiles env before running it, or check install-script ordering                                                                                                                                        |
| Fresh box, plugins missing after cloning dotfiles                              | No `--recurse-submodules` needed (we don't use submodules) — just run `install-plugins.sh` once                                                                                                                     |
| `.gitignore` rule added but path still shows in `git status`                   | The path is already tracked — `.gitignore` never affects tracked files. Run `git rm -r --cached <path>`, then re-add                                                                                                |
| `git add` warns "adding embedded git repository"                               | A plugin dir still has its own `.git` — shouldn't happen with current `install-plugins.sh` (it strips `.git` post-clone); if seen, re-run the regenerate steps above                                                |
| `%` doesn't jump HTML tags / if-else blocks                                    | `packadd! matchit` didn't load — check it's present near the bottom of `.vimrc` after `packloadall`                                                                                                                 |
| `:grep` is slow / uses wrong syntax                                            | Confirm `rg` is on `$PATH`; `grepprg` is set to ripgrep, not builtin grep                                                                                                                                           |
| Big log/JSON file feels sluggish                                               | Expected under 5MB threshold to trip the large-file guard — check `getfsize()` against the threshold if a merely-large file still lags                                                                              |

## Using `:help`

- `:help` (or `:h`) alone → opens the main help index
- `:h {topic}` → jump straight to a topic, e.g. `:h :s`, `:h 'number'`, `:h CTRL-V`
- `:h {plugin-command}` → works for plugin docs too, once `:helptags ALL` has run,
  e.g. `:h :Git`, `:h surround`, `:h fzf-vim-commands`
- `Ctrl-]` on any `|word|` in a help page → jump to that tag
- `Ctrl-o` / `Ctrl-i` → back / forward through help jump history (like browser back/forward)
- `:helpgrep {pattern}` → full-text search across all help files, results in quickfix (`:cnext`/`:cprev`)
- `:h help-summary` → meta-help: how the whole help system works

**Syntax cheatsheet for what to search:**

| Prefix in docs       | Means               | Example          |
|----------------------|---------------------|------------------|
| `'...'`              | an option           | `:h 'clipboard'` |
| `` `...` `` or plain | a command           | `:h :vsplit`     |
| `CTRL-X`             | a key/mapping       | `:h CTRL-W`      |
| `i_...`              | insert-mode mapping | `:h i_CTRL-N`    |
| `v_...`              | visual-mode mapping | `:h v_iw`        |
| `'option'!`          | shorthand, rare     | —                |

Quick escape hatch when you don't know the exact tag: `:h` then `Ctrl-d` to
list completions, or just `:helpgrep` the rough term.

