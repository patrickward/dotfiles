# tmux Configuration

**Tested with:** tmux 3.7 on macOS (ghostty terminal)  
**Shell:** zsh  
**Config:** `~/.tmux.conf` (symlinked from dotfiles)

---

## Changed Defaults

These settings differ from tmux's out-of-the-box defaults. Marked so you know what you're overriding.

| Setting            | tmux Default      | This Config             | Why                                            |
|--------------------|-------------------|-------------------------|------------------------------------------------|
| `prefix`           | `C-b`             | `C-a`                   | GNU Screen muscle memory                       |
| `base-index`       | `0`               | `1`                     | Windows numbered from 1                        |
| `pane-base-index`  | `0`               | `1`                     | Panes numbered from 1                          |
| `renumber-windows` | `off`             | `on`                    | No gaps after close                            |
| `escape-time`      | `10ms` (3.5+)     | `1ms`                   | Faster neovim mode switching                   |
| `history-limit`    | `2000`            | `50000`                 | More scrollback                                |
| `focus-events`     | `off`             | `on`                    | neovim FocusGained/Lost events                 |
| `display-time`     | `750ms`           | `4000ms`                | Messages stay readable                         |
| `mouse`            | `on` (3.7+)       | `on`                    | Explicit; was off in older versions            |
| `monitor-activity` | `off`             | `on`                    | Highlights windows with activity               |
| `set-titles`       | `off`             | `on`                    | Terminal title = session name                  |
| pane nav           | `prefix + arrows` | `C-h/j/k/l` (no prefix) | Vim-style, no prefix required                  |
| splits             | `prefix + %/"`    | `prefix + \\ / -`       | Mnemonic: `\` = horizontal bar, `-` = vertical |
| new-window dir     | home dir          | current dir             | Stays in project directory                     |

---

## Key Bindings

### Prefix

The prefix is **`C-a`** (Ctrl+A), not the default `C-b`.

To send a literal `C-a` to an inner application (e.g., nested tmux, Emacs):
- `C-a a`
- `C-a C-a`

### Sessions

| Binding   | Action                                                           |
|-----------|------------------------------------------------------------------|
| `C-a C-j` | Session/window tree chooser                                      |
| `C-a C-b` | Break current pane into new session (named after dir, via `tat`) |
| `C-a K`   | Kill current session, switch to next (stays in tmux)             |

### Windows

| Binding | Action                             |
|---------|------------------------------------|
| `C-a c` | New window in current directory    |
| `C-a b` | Break current pane into new window |
| `C-a r` | Reload `~/.tmux.conf`              |

### Panes

| Binding                 | Action                                           |
|-------------------------|--------------------------------------------------|
| `C-a -`                 | Split vertically (new pane below), current dir   |
| `C-a \`                 | Split horizontally (new pane right), current dir |
| `C-h / C-j / C-k / C-l` | Navigate panes (no prefix needed)                |
| `S-Left/Right/Down/Up`  | Resize pane (no prefix needed)                   |
| `C-a h`                 | Open htop in a split pane                        |

### Copy Mode

Entry: `C-a [` (default)

| Binding    | Action                                 |
|------------|----------------------------------------|
| `v`        | Begin selection                        |
| `y`        | Yank to macOS clipboard (`pbcopy`)     |
| `Enter`    | Copy selection to clipboard and exit   |
| Mouse drag | Copy selection to clipboard on release |

---

## External Dependencies

- **`tat` script** — Required for `C-a C-b` (break into named session). Source from [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles/blob/main/bin/tat) and put it in your `$PATH`.
- **`pbcopy`** — macOS built-in; copy mode pipes selections here.
- **`htop`** — Required for `C-a h` quick pane. Install via `brew install htop`.

---

## No Plugins

This config has no plugin dependencies (no tpm). Everything is native tmux 3.7.

Previously used plugins (removed):
- `tmux-plugins/tpm` — plugin manager, no longer needed
- `tmux-plugins/tmux-sensible` — sane defaults, now absorbed directly into this config
- `dracula/tmux` — status bar theme, replaced by ghostty's built-in Dracula theme

---

## Terminal Color Notes

This config sets `default-terminal` to `tmux-256color`. Ghostty handles the actual color theme (Dracula). No tmux-level theme is applied.

Pane borders use 256-color values (`colour235` / `colour240`). If you switch to a terminal without Dracula context, borders will use standard grey tones.
