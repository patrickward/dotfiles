<!-- topics/vim/PLUGINS.md -->
# Plugin basics

Quick reference for each plugin — just enough to be productive. Full docs
via `:h {plugin}` (see README's help section) once `:helptags ALL` has run.

> **Note**: After installation, run `:PlugInstall` in Vim to install all plugins.
> Use `:PlugUpdate` to update, `:PlugClean` to remove unreferenced plugins.

## vim-surround — pairs (quotes, brackets, tags)

Verbs: `ds` (delete), `cs` (change), `ys` (add, "you-surround"). Targets are
a character (`"`, `'`, `(`, `[`, `t` for tag) or a motion/text-object .

| Command            | Effect                         |
|--------------------|--------------------------------|
| `ds"`              | delete surrounding `"`         |
| `cs"'`             | change surrounding `"` → `'`   |
| `cst<p>`           | change surrounding tag → `<p>` |
| `ysiw)`            | wrap inner word in `()`        |
| `yss"`             | wrap entire line in `"`        |
| `S"` (visual mode) | wrap selection in `"`          |

## vim-commentary — comment toggling

| Command            | Effect                                                |
|--------------------|-------------------------------------------------------|
| `gcc`              | toggle comment on current line                        |
| `gc{motion}`       | toggle comment over motion, e.g. `gcap` (a paragraph) |
| `gc` (visual mode) | toggle comment on selection                           |

## vim-unimpaired — bracket pairs

`[` = previous/above, `]` = next/below, `yo` = toggle an option. Full set is
documented as complementary pairs of ex-command aliases and option toggles .

| Command                 | Effect                                                 |
|-------------------------|--------------------------------------------------------|
| `]q` / `[q`             | next / previous quickfix entry (`:cnext`/`:cprevious`) |
| `]Q` / `[Q`             | last / first quickfix entry                            |
| `]a` / `[a`             | next / previous file in arglist                        |
| `]b` / `[b`             | next / previous buffer                                 |
| `]f` / `[f`             | next / previous file in current directory              |
| `]e` / `[e`             | move current line down / up                            |
| `]<Space>` / `[<Space>` | add blank line below / above (stays in normal mode)    |
| `yos`                   | toggle spellcheck                                      |
| `yow`                   | toggle line wrap                                       |
| `yon`                   | toggle line numbers                                    |
| `yol`                   | toggle `listchars` display                             |
| `yoh`                   | toggle search highlight                                |

## vim-fugitive — git

| Command          | Effect                                                                              |
|------------------|-------------------------------------------------------------------------------------|
| `:Git` (or `:G`) | status window — `s`/`u` to stage/unstage under cursor, `cc` to commit, `dd` to diff |
| `:Gdiffsplit`    | diff current file against index/HEAD; `do`/`dp` to pull/push hunks between splits   |
| `:Git blame`     | blame column; `q` to close                                                          |
| `:Git log`       | log; `<CR>` on a commit to view it                                                  |
| `:Gread`         | reload file from index (discard unstaged changes)                                   |
| `:Gwrite`        | stage current file (like `git add %`)                                               |

Mapped in `.vimrc`: `<leader>gs` (status), `<leader>gd` (diffsplit), `<leader>gb` (blame).

## editorconfig-vim — no commands needed

Reads `.editorconfig` on file open and silently sets `shiftwidth`/`expandtab`/
etc. to match. `:EditorConfigReload` re-applies if you edit `.editorconfig`
mid-session. If indentation looks "wrong," check for a `.editorconfig`
upstream before touching `.vimrc`.

## fzf.vim — fuzzy finding

Requires both `fzf` (binary + vim API) and `fzf.vim` (commands) — see
troubleshooting in README if commands error out.

| Command      | Effect                                      |
|--------------|---------------------------------------------|
| `:Files`     | fuzzy find files (`<leader>f`)              |
| `:GFiles`    | fuzzy find git-tracked files (`<leader>g`)  |
| `:Rg {term}` | ripgrep search, live-updating (`<leader>r`) |
| `:Buffers`   | fuzzy find open buffers (`<leader>b`)       |

Inside any fzf window: `Tab` multi-select, `Ctrl-T` open in new tab,
`Ctrl-X` open in horizontal split, `Ctrl-V` open in vertical split.

## vim-tmux-runner — send code to a tmux pane

Requires running inside tmux. Workflow: open a runner pane once, then keep
sending lines/commands to it .

| Command                   | Effect                                                        |
|---------------------------|---------------------------------------------------------------|
| `:VtrOpenRunner`          | split a new tmux pane as the "runner" (`<leader>vr`)          |
| `:VtrAttachToPane`        | attach an *existing* pane as runner instead                   |
| `:VtrSendLinesToRunner`   | send current line / visual selection to runner (`<leader>vs`) |
| `:VtrSendCommandToRunner` | prompt for an arbitrary shell command, send it                |
| `:VtrKillRunner`          | close the runner pane                                         |

If you see `VTR: No runner pane attached`, run `:VtrAttachToPane` .
