# Vim as a Language

## The mental shift

When I first learned Vim, I focused mostly on memorizing the various commands. And that approach got me pretty far, but it limits me to the few commands I've memorized. So, this document tries to produce a different approach: stop thinking of Vim commands as a list of bindings, and start thinking of them as sentences in a small, consistent language. Hopefully, if that clicks, I'll only need to memorize the grammar, a handful of verbs and nouns, and how they can be combined. That's a more efficient approach.

---

## The grammar

Vim's Normal mode has two valid sentence forms.

**Form 1 — move:**

```text
[count] motion
```

**Form 2 — edit:**

```text
[count] ["register] verb [count] motion-or-text-object
```

Form 1 is a complete command by itself. `5j` moves down 5 lines. `3w` moves forward 3 words. `f;` jumps to the next semicolon. No verb, no object — just a motion, optionally multiplied by a count. This is how you navigate.

Form 2 performs an edit. The verb names the operation, and the motion or text object names the target. `d3w` deletes 3 words. `"ayiw` yanks the inner word into register `a`. The optional register prefix (the `"a` part) redirects where the result goes or comes from.

### The dual role of motions

This is the key to composability: **every motion works in both forms.** `w` alone (Form 1) moves the cursor forward one word. `dw` (Form 2) uses that same `w` as the noun — the verb `d` consumes the motion and acts on the text it would have traversed. The motion itself doesn't change; only its role in the sentence does. Learn the motions once; they work everywhere.

### Why composability matters

10 verbs × 20 motions and text objects = 200 commands you don't have to memorize separately. When you learn that `gU` is an operator (force uppercase), you already know that `gUiw` uppercases a word, `gU$` uppercases to end of line, and `gUap` uppercases a paragraph — because those are nouns you already know.

### Counts

A count multiplies the next element. Counts can appear before the verb, before the noun, or both — when both are given, they multiply.

| Command | Means                                   |
|---------|-----------------------------------------|
| `5j`    | Move down 5 lines (Form 1)              |
| `3w`    | Move forward 3 words (Form 1)           |
| `3dd`   | Delete 3 lines                          |
| `d3w`   | Delete 3 words                          |
| `3dw`   | Delete 3 words (same as above)          |
| `2d3w`  | Delete 6 words                          |
| `2di(`  | Widen 2 bracket levels out, then delete |

Use counts deliberately rather than habitually. For large jumps (`15j`), a count is precise. For deleting 2–3 words, a text object like `daw` repeated with `.` is often more legible.

---

## Context determines meaning

This is the single most important thing to internalize about Vim's design: **the same key does different things depending on what mode you're in and what came before it.**

Vim is not inconsistent. It is *context-layered*. A small alphabet is reused across multiple contexts deliberately, because most contexts are mutually exclusive — you can't be in Normal mode and also be mid-text-object selection at the same time.

The key conflicts that trip people up the most:

| Key | In Normal mode (standalone)                           | After a verb (operator-pending), or prefixed with `i`/`a`                                 |
|-----|-------------------------------------------------------|-------------------------------------------------------------------------------------------|
| `i` | Enter Insert mode                                     | The "inner" qualifier for text objects: `diw`, `ci"`, `yip`                               |
| `a` | Append (enter Insert mode *after* the cursor)         | The "around" qualifier for text objects: `daw`, `ca(`, `yap`                              |
| `b` | Move backward one word (a motion)                     | Alias for `(` as a text object — `dib` = delete inside `()`                               |
| `B` | Move backward one WORD (a motion)                     | Alias for `{` as a text object — `diB` = delete inside `{}`                               |
| `t` | "till" motion: move to just before a character (`t;`) | Text object: HTML/XML tag pair — `dit` = delete inside `<tag>...</tag>`                   |
| `w` | Move forward one word (a motion)                      | Text object component: `iw` = inner word, `aw` = a word + space                           |
| `p` | Paste from register                                   | Text object component: `ip` = inner paragraph, `ap` = paragraph + surrounding blank lines |
| `s` | Substitute character under cursor (enters Insert)     | In Ex mode: the separator in `:s/pat/rep/` — unrelated                                    |

The rule for resolving ambiguity: **look at what came before the key.** If nothing has been pressed yet and you're in Normal mode, `i` enters Insert. If you just pressed a verb like `d` or `c` or `y`, Vim is in operator-pending mode, and `i` is now the "inner" qualifier waiting for an object character. These are mechanically distinct states; Vim is never confused about which one it's in, even if you sometimes are.

---

## Modes

| Mode                 | What's true while in it                                                 |
|----------------------|-------------------------------------------------------------------------|
| **Normal**           | Keys are commands. This is the *home* mode — return here between edits. |
| **Insert**           | Keys produce literal text.                                              |
| **Visual**           | A selection exists; the next verb applies to it.                        |
| **Command-line**     | You're typing after `:`, `/`, or `?`.                                   |
| **Operator-pending** | You've typed a verb; Vim is waiting for a noun to complete the command. |

Normal mode is not just where you start — it's where you spend most of your time. Edits are brief excursions into Insert mode, not long residencies. The habit of returning to Normal after each logical change is what makes the dot command and the grammar work.

### Operator-pending mode

When you press a verb like `d`, nothing happens visually, but Vim has changed states: it is now specifically waiting for a noun (a motion or text object). Every motion and text object you type in this state completes the pending verb. `Esc` cancels the verb and returns to Normal. This is also why `i` and `a` can act as text object qualifiers in this state — Vim knows it's waiting for a noun, so it interprets `i` and `a` as "what kind of object follows?" rather than "enter Insert mode." Recognizing when you're in operator-pending mode removes the anxiety of half-typed commands.

---

## Verbs (operators)

| Verb               | Effect                                          |
|--------------------|-------------------------------------------------|
| `d`                | Delete (cut)                                    |
| `c`                | Delete, then enter Insert mode                  |
| `y`                | Yank (copy)                                     |
| `>` / `<`          | Indent / outdent                                |
| `=`                | Reindent                                        |
| `gu` / `gU` / `g~` | Force lowercase / force uppercase / toggle case |
| `gq`               | Reformat to `textwidth`                         |
| `!`                | Filter through an external shell command        |

Vim has 16 operators in total (`:h operator`); these cover daily editing.

**Doubling** a verb applies it to the whole current line: `dd`, `cc`, `yy`, `>>`, `gUU`, `gqq`.

**Capitalizing** a verb usually means "to end of line" (equivalent to `{verb}$`): `D` = `d$`, `C` = `c$`. **`Y` is the historical exception** — it behaves like `yy` (whole line), not `y$`, for compatibility with the original `vi`. Many people add `nnoremap Y y$` to their vimrc. Know which behavior you have.

**Special case:** `cw` is treated like `ce` when the cursor is on a non-blank character. Conceptually, "change word" means change up to the end of the word, not including trailing whitespace. `dw` does *not* have this exception and includes the trailing space.

---

## Entering Insert mode

These are all standalone Normal-mode commands — none of them are text-object qualifiers.

| Command          | Cursor position                                       |
|------------------|-------------------------------------------------------|
| `i`              | Insert before the cursor                              |
| `a`              | Insert after the cursor (append)                      |
| `I`              | Insert at the first non-blank of the line             |
| `A`              | Insert at the end of the line                         |
| `o` / `O`        | Open a new line below / above, then insert            |
| `gi`             | Re-enter Insert at the last Insert-mode exit position |
| `Esc` / `Ctrl-[` | Return to Normal mode                                 |

When `i` and `a` appear as part of a text object (like `diw` or `ca"`), they are not these commands. They are the first keystroke of a two-key text object prefix typed while Vim is in operator-pending mode. The letter happens to be the same; the mode and prior context make them unambiguous to Vim.

### Commands available inside Insert mode

Insert mode is not a passive text-entry state. Several commands are available *while in Insert mode* without leaving it:

| Key                 | Effect                                                                                             |
|---------------------|----------------------------------------------------------------------------------------------------|
| `Ctrl-w`            | Delete the word before the cursor                                                                  |
| `Ctrl-u`            | Delete from the cursor back to the start of the line                                               |
| `Ctrl-r {reg}`      | Insert the contents of `{reg}` at the cursor position                                              |
| `Ctrl-r =`          | Insert the result of an expression (opens a prompt)                                                |
| `Ctrl-t` / `Ctrl-d` | Indent / outdent the current line by one `shiftwidth`                                              |
| `Ctrl-n` / `Ctrl-p` | Keyword completion: next / previous match                                                          |
| `Ctrl-g u`          | Create an undo breakpoint (splits the current Insert session into two separately undoable changes) |
| `Ctrl-o {cmd}`      | Execute one Normal-mode command, then return to Insert mode                                        |

`Ctrl-r 0` pastes the last yanked text inline without leaving Insert mode — useful when you're mid-sentence and need to repeat a term. `Ctrl-r =` is a calculator: `Ctrl-r = 24*60<Enter>` inserts `1440` at the cursor.

`Ctrl-o` is a trapdoor to Normal mode for a single command. `Ctrl-o zz` recenters the screen while you're typing without breaking your Insert session. `Ctrl-o D` deletes from the cursor to end of line and returns you to Insert — the kind of thing that would otherwise require `Esc D i`.

Note: `Ctrl-d` here (outdent in Insert) is different from `Ctrl-d` in Normal mode (scroll half-page down). Context — which mode you're in — determines which one fires.

---

## Nouns: motions

A motion answers: *where do I go from here?* Motions have two properties that matter for operators:

**Inclusive vs. exclusive:** An inclusive motion includes the character at the endpoint in the operation. An exclusive motion does not. This is why `de` deletes through and including the last letter of the word, while `dw` stops before the first character of the *next* word — `e` is inclusive, `w` is exclusive. It's not inconsistency; it's deliberate. `:h motion.txt` lists which motions are which.

**word vs. WORD:** `w`, `b`, `e` navigate by *word*: a sequence of letters, digits, and underscores, or a sequence of non-blank punctuation characters, separated by whitespace. `W`, `B`, `E` navigate by *WORD*: any sequence of non-blank characters, delimited only by whitespace. In practice: `w` stops at punctuation boundaries; `W` skips over them. `dW` on `foo.bar(baz)` deletes the whole token in one shot.

### Character and line motions

| Grain                       | Backward / left | Forward / right |
|-----------------------------|-----------------|-----------------|
| Character                   | `h`             | `l`             |
| Line                        | `k` (up)        | `j` (down)      |
| Word (stops at punctuation) | `b` / `B`       | `w` / `W`       |
| Word end                    | `ge` / `gE`     | `e` / `E`       |
| Paragraph                   | `{`             | `}`             |
| Sentence                    | `(`             | `)`             |
| File                        | `gg`            | `G`             |

Note: `b` and `B` here are **motions** — they move the cursor. When they appear after a verb as part of a text object (e.g., `dib`), `b` means "parenthesis block," not the backward-word motion. Context (operator-pending mode + the preceding `i` or `a`) is what switches the interpretation.

### Line position motions

| Motion | Goes to                                      |
|--------|----------------------------------------------|
| `0`    | Column 0 (absolute start of line)            |
| `^`    | First non-blank character                    |
| `$`    | End of line (including trailing whitespace)  |
| `g_`   | Last non-blank character (complement of `^`) |

### Find / till (crucial for the dot formula)

| Motion          | Goes to                                                                             |
|-----------------|-------------------------------------------------------------------------------------|
| `f{c}` / `F{c}` | Next / previous occurrence of `{c}`, landing **on** it (inclusive)                  |
| `t{c}` / `T{c}` | Next / previous occurrence of `{c}`, landing just **before / after** it (exclusive) |
| `;` / `,`       | Repeat last `f`/`F`/`t`/`T` in the same / reversed direction                        |

`t` as a **motion** is "till" — move to just before a character. `t` as a **text object** (in `dit`, `dat`) is "tag" — the HTML/XML tag surrounding the cursor. These share a letter but are used in different positions: the motion `t` is followed by the target character (`t;`), while the text object `t` is preceded by `i` or `a` (`dit`). You can't confuse them in practice because you're either typing a motion or completing a text object.

`f` and `t` are some of the most useful motions for precise edits. `dt;` deletes from the cursor to just before the next semicolon. `ci"` changes the contents inside the next pair of quotes.

### Other motions

| Motion                    | Goes to                                                   |
|---------------------------|-----------------------------------------------------------|
| `%`                       | Matching bracket / delimiter                              |
| `H` / `M` / `L`           | Top / middle / bottom of visible screen                   |
| `` `{mark} `` / `'{mark}` | Exact position / first non-blank of a marked line         |
| `n` / `N`                 | Next / previous search match (same or reversed direction) |

---

## Nouns: text objects

A text object answers a different question: *what shape am I standing in?* Unlike a motion — which is directional from the cursor — a text object selects a whole structural unit regardless of where inside it the cursor sits.

Every text object is two keystrokes: a qualifier (`i` or `a`), followed by an object character. These `i` and `a` qualifiers are **only valid in operator-pending mode or Visual mode** — they are not commands in their own right. Outside those contexts, `i` enters Insert mode and `a` appends; inside those contexts, Vim is explicitly waiting for a noun and interprets them as qualifiers.

- **`i`** ("inner") selects the contents of the object, not the delimiters.
- **`a`** ("around") selects the contents *plus* the delimiters (or trailing whitespace for words, sentences, and paragraphs).

| Object          | `i` selects                     | `a` selects                         |
|-----------------|---------------------------------|-------------------------------------|
| `w` / `W`       | word / WORD contents            | word/WORD + trailing space          |
| `s`             | sentence contents               | sentence + trailing space           |
| `p`             | paragraph contents              | paragraph + surrounding blank lines |
| `"` `'` `` ` `` | contents inside quotes          | contents + the quote characters     |
| `(` or `b`      | contents inside `()`            | contents + the parentheses          |
| `{` or `B`      | contents inside `{}`            | contents + the braces               |
| `[`             | contents inside `[]`            | contents + the brackets             |
| `t`             | contents inside an XML/HTML tag | contents + the tag pair             |

`b` (parentheses) and `B` (braces) are aliases here — chosen because they're visually similar to `(` and `{` but easier to type. They overlap with the motion keys `b` (backward word) and `B` (backward WORD), but again, context resolves it: `dib` is `d` (verb) + `i` (inner qualifier) + `b` (parentheses object) — the `b` comes after `i`, so it can only mean parentheses. `db` is `d` (verb) + `b` (backward-word motion) — no `i`/`a` precedes `b`, so it's a motion.

**`dw` vs. `daw`:** `dw` deletes from the current cursor position to the start of the next word — if you're mid-word, you only get part of it. `daw` always deletes the entire word plus trailing space, no matter where the cursor is in the word. This is the text object advantage: results are predictable regardless of cursor position.

Similarly, `p` is a text object (paragraph) in `dip` or `yap`, and a paste command in Normal mode. The disambiguation: `d` + `i` + `p` is unambiguous because after `di`, Vim is waiting for an object character. `p` alone in Normal mode is paste.

**Nesting:** Text objects understand nesting. With the cursor anywhere on `y` in `(x (y) z)`, `di(` deletes `y`; `2di(` widens one bracket level out and deletes `x (y) z`.

Text objects only work with operators (in operator-pending mode) and inside Visual mode — they are not standalone cursor movements.

---

## Buffers 

It's important to understand the concept of buffers in Vim. A buffer is a temporary representation of a file in memory. When you open a file in Vim, it is loaded into a buffer. You can have multiple buffers open at the same time, each representing a different file. 

A window is essentially a view into the buffer. When you open a file in Vim, it is loaded into a buffer, and a window is created to display that buffer. You can have multiple windows open at the same time, each displaying a different buffer. 

| Command          | Effect                                                      |
|------------------|-------------------------------------------------------------|
| `:edit [<file>]` | Edit the specified file in a new buffer. [File is optional] |
| `:edit`          | Edit without any arguments reloads the current buffer       |
| `:new [<file>]`  | Create a new buffer. [File is optional]                     |
| `:new`           | New without any arguments simply opens a new buffer         | 
| `:vnew [<file>]` | Open a new file in a new buffer split vertically            |
| `:buffers`       | View the full list of buffers                               | 
| `:ls`            | Alias. View the full list of buffers                        | 
| `:files`         | Alias. View the full list of buffers                        | 

---

## Navigation

### Scrolling the viewport

These commands reposition the viewport around the cursor without changing the cursor's position in the file. They complement `H`/`M`/`L`, which move the *cursor* to the viewport edges — `zz`/`zt`/`zb` move the *viewport* around the cursor.

| Command             | Effect                                                       |
|---------------------|--------------------------------------------------------------|
| `zz`                | Center the current line in the window                        |
| `zt`                | Scroll so the current line is at the top of the window       |
| `zb`                | Scroll so the current line is at the bottom of the window    |
| `Ctrl-d` / `Ctrl-u` | Scroll half a page down / up (cursor moves with it)          |
| `Ctrl-f` / `Ctrl-b` | Scroll a full page forward / backward (cursor moves with it) |
| `Ctrl-e` / `Ctrl-y` | Scroll the viewport one line down / up (cursor stays put)    |

`zz` deserves particular attention: after jumping to a match or a mark, the target line is often at the very top or bottom of the screen. `zz` recenters it immediately. The muscle memory sequence `n` then `zz` — find next match, recenter — is worth building deliberately.

### The jump list

Vim maintains a **jump list** — a history of cursor positions resulting from "large" motions: searches (`/`, `n`), file-level jumps (`gg`, `G`, `%`), mark jumps (`` `a ``), and inter-file navigation. It is separate from the undo tree.

| Command  | Effect                                         |
|----------|------------------------------------------------|
| `Ctrl-o` | Jump to the previous position in the jump list |
| `Ctrl-i` | Jump to the next position in the jump list     |
| `:jumps` | Display the full jump list                     |

`Ctrl-o` / `Ctrl-i` are among the most-used navigation commands in practice. After jumping across the file to look something up, `Ctrl-o` brings you back to exactly where you were. Note: small motions (`hjkl`, `w`, `b`) do not add to the jump list — only significant positional changes do.

### The change list

Separate from the jump list, Vim tracks the position of every *change* made to the buffer. Where `` `. `` jumps to the position of the last change, the change list lets you walk through all of them.

| Command    | Effect                                                                                    |
|------------|-------------------------------------------------------------------------------------------|
| `g;`       | Jump to the previous change position                                                      |
| `g,`       | Jump to the next change position                                                          |
| `` `. ``   | Jump to the position of the most recent change (shorthand for the top of the change list) |
| `:changes` | Display the full change list                                                              |

The change list is useful when you've navigated away from an edit and need to return to a sequence of recent changes — more targeted than the jump list, which includes read-only navigation.

### Navigating Windows 

Moving between windows. Use `Ctrl-w` + `<direction>` to move the viewport to the window in that direction.

| Command         | Effect                                                                  |
|-----------------|-------------------------------------------------------------------------|
| `:sp [<file>]`  | Split to a new horizontal window.                                       |
| `:sp`           | Without a file, the split opens the same buffer in a horizontal window. |
| `:vsp [<file>]` | Split to a new vertical window.                                         |
| `:vsp`          | Without a file, the split opens the same buffer in a vertical window.   |
| `Ctrl-w` + `w`  | Move the viewport to the next window                                    |
| `Ctrl-w` + `W`  | Move the viewport to the previous window                                |
| `Ctrl-w` + `h`  | Move the viewport to the left window                                    |
| `Ctrl-w` + `H`  | Move the viewport to the leftmost window                                |
| `Ctrl-w` + `l`  | Move the viewport to the right window                                   |
| `Ctrl-w` + `L`  | Move the viewport to the rightmost window                               |
| `Ctrl-w` + `j`  | Move the viewport to the top window                                     |
| `Ctrl-w` + `J`  | Move the viewport to the bottom window                                  |
| `Ctrl-w` + `k`  | Move the viewport to the topmost window                                 |
| `Ctrl-w` + `K`  | Move the viewport to the bottommost window                              |

Closing windows and tabs.

| Command        | Effect                                              |
|----------------|-----------------------------------------------------|
| `:quit`        | Quit the current window                             |
| `Ctrl-w` + `q` | Quit the current window                             |
| `:close`       | Close the current window with a warning             |
| `Ctrl-w` + `c` | Close the current window with a warning             |
| `:only`        | Leave only the active window open, close all others |
| `Ctrl-w` + `o` | Leave only the active window open, close all others |

### Navigating and Controlling Tabs 

Creating and moving tabs:

| Command             | Effect                                                       |
|---------------------|--------------------------------------------------------------|
| `:tabnew`           | Create a new tab                                             |
| `:tabc`             | Close the current tab                                        |
| `:tabo`             | Close all other tabs                                         |
| `:tabdo <cmd>`      | Execute a command on all tabs                                |
| `:tabm <n>`         | Move the current tab to position `<n>`                       |
| `gt`                | Move to the next tab                                         |
| `gT`                | Move to the previous tab                                     |
| `Ctrl-w` + `T`      | Split to new tab                                             |
| `gt`                | Move to the next tab                                         |
| `gT`                | Move to the previous tab                                     |
| `<n>gt`             | Move to tab `<n>`                                            |

---

## Shape: characterwise, linewise, blockwise

Every motion and text object carries a shape tag. That tag is stored with the yanked or deleted text and determines what `p` does:

| Shape         | How it's produced                  | `p` behavior                                        |
|---------------|------------------------------------|-----------------------------------------------------|
| Characterwise | `dw`, `de`, `daw`, `df;`           | Inserts inline, after the cursor                    |
| Linewise      | `dd`, `dj`, `d}` (when full lines) | Inserts as a new line below                         |
| Blockwise     | `Ctrl-v` rectangular selection     | Inserts as a rectangular block at the cursor column |

This is why `yyp` duplicates the current line below (linewise yank → linewise paste), while `yiwp` drops the word inline at the cursor (characterwise yank → characterwise paste). Same verb, same paste key, different outcome — entirely determined by the shape of the noun.

---

## Complete commands (no noun needed)

These act immediately without entering operator-pending mode because their target is implicit:

| Command    | Effect                                                    |
|------------|-----------------------------------------------------------|
| `x` / `X`  | Delete character under / before cursor                    |
| `s` / `S`  | Substitute character / whole line (enters Insert)         |
| `r{c}`     | Replace one character under cursor, stay in Normal        |
| `~`        | Toggle case of character under cursor, advance            |
| `J` / `gJ` | Join line below onto current line, with / without a space |
| `p` / `P`  | Paste register after / before cursor                      |
| `.`        | Repeat last change                                        |

Note: `s` here is the standalone substitute — it deletes the character under the cursor and enters Insert. It is unrelated to the `:s/pattern/replacement/` Ex command (where `s` is just the name of the substitute command, and the slashes are its argument separators). Don't conflate them.

---

## The dot command and the Dot Formula

`.` replays the last *change* — the last insert, delete, yank, or operator+noun command — exactly as typed, including any count. This is the payoff for composing deliberate verb+noun commands.

The **Dot Formula** (from Drew Neil's *Practical Vim*): structure your edits so that one keystroke moves and one keystroke repeats. The typical pattern is:

```
/pattern   " find the first target
c{noun}    " make the change (one clean command)
n.         " jump to the next match, repeat the change
n.         " again
;.         " or use ; to repeat f/t, then . to repeat the change
```

`cgn` is a particularly tight application: `c` changes the text selected by `gn` (the current/next search match as a text object), then `.` jumps to and changes the *next* match in one keystroke.

What breaks repeatability: arrow-key navigation mid-edit, mouse clicks, or any sequence of independent commands that Vim records as separate changes. A `ci"new text<Esc>` is one change. Navigating with `hjkl`, deleting a character, inserting another — those are three separate changes; `.` only replays the last one.

---

## Registers

Every delete and yank goes into a register. Understanding which register holds what is what separates paste-that-works from paste-that-loses-your-yank.

| Register       | Holds                                                                                                         |
|----------------|---------------------------------------------------------------------------------------------------------------|
| `""` (unnamed) | Last delete **or** yank. This is what `p` uses by default.                                                    |
| `"0`           | Last **yank** specifically. Deletes do not overwrite it.                                                      |
| `"1`–`"9`      | Rolling delete history. `"1` is the most recent delete; each subsequent delete pushes the previous ones down. |
| `"a`–`"z`      | Named registers. Used only when you explicitly address them.                                                  |
| `"A`–`"Z`      | Same registers as `a`–`z`, but **append** rather than replace.                                                |
| `"_`           | The black hole. Discards without overwriting `""`.                                                            |
| `"+`           | System clipboard.                                                                                             |

**The common gotcha:** you yank a word with `yiw`, navigate somewhere, delete a line with `dd` — and now `p` pastes the deleted line, not the word, because `dd` overwrote `""`. The fix: paste from `"0p` (last yank). Or, if the delete was a throwaway, use `"_dd` so `""` is never touched.

Prefix any verb with `"{reg}` to direct it: `"ayy` yanks the line into register `a`, `"ap` pastes from `a`, `"_dd` deletes to the void. Note that `"` here is the register-prefix operator, not a quote character — it's always followed by a single register name.

---

## Marks

A mark is a remembered cursor position. Because marks are motions, they compose with operators.

| Command       | Effect                                         |
|---------------|------------------------------------------------|
| `m{a-z}`      | Set a local mark (per file)                    |
| `m{A-Z}`      | Set a global mark (persists across files)      |
| `` `{mark} `` | Jump to the exact position of the mark         |
| `'{mark}`     | Jump to the first non-blank of the mark's line |
| ` `` `        | Jump to position before the last jump          |
| `''`          | Jump to line before the last jump              |
| `` `. ``      | Jump to the position of the last change        |

`` d`a `` is an ordinary verb+motion command: delete from here to the exact position of mark `a`. This makes marks useful for defining arbitrary ranges without counting lines.

Note: `m` sets a mark in Normal mode; `:m` (followed by a line number) is the Ex command to *move* a range of lines. Same letter, completely different contexts — one is a Normal-mode command, the other is a colon-prefixed Ex command.

---

## Search as a noun

Search results are motions, and search matches can be text objects.

| Command         | Effect                                                      |
|-----------------|-------------------------------------------------------------|
| `/pat` / `?pat` | Search forward / backward                                   |
| `n` / `N`       | Repeat search, same / reversed direction                    |
| `*` / `#`       | Search for the word under the cursor, forward / backward    |
| `gn` / `gN`     | Select the current / previous match as a visual text object |

`d/foo<Enter>` is verb+motion: delete from here to the next occurrence of `foo`. `cgn` is verb+text-object: change the current match. Because `.` replays `cgn` cleanly and advances to the next match automatically, it's a practical alternative to `:s` for a small number of targeted substitutions.

---

## The `g` prefix

`g` has no single meaning, but a consistent role: it introduces a finer-grained or display-aware variant of a related command, or a command that simply has no non-`g` form.

| Command            | vs. the plain version                                               |
|--------------------|---------------------------------------------------------------------|
| `ge` / `gE`        | Word-end, backward (no non-`g` equivalent)                          |
| `g_`               | Last non-blank (vs. `$`, which lands after last non-blank)          |
| `gj` / `gk`        | Move by *displayed* line, not file line (matters when `wrap` is on) |
| `g0` / `g$`        | Start / end of *displayed* line                                     |
| `gu` / `gU` / `g~` | Case operators (no non-`g` form)                                    |
| `gq`               | Reformat to `textwidth` (no non-`g` form)                           |
| `gJ`               | Join without inserting a space                                      |
| `gi`               | Re-enter Insert mode at the last Insert-mode exit position          |
| `gv`               | Reselect the last Visual selection                                  |
| `gn` / `gN`        | Select the match as a text object, not just navigate to it          |

---

## Visual mode

| Command  | Selects                              |
|----------|--------------------------------------|
| `v`      | Characterwise (free-form characters) |
| `V`      | Linewise (whole lines)               |
| `Ctrl-v` | Blockwise (rectangular region)       |
| `gv`     | Reselect the last Visual selection   |

In Visual mode, the grammar is reversed: **noun then verb**. You select first (the noun), then press the operator (the verb). `viw` then `d` produces the same result as `diw` in Normal mode.

Visual mode is most useful when the target is hard to name precisely — a ragged multi-line selection, or a region you want to eyeball. When the target *can* be named with a text object or motion, prefer the Normal-mode form: `diw` over `viwd`. Normal-mode operator+noun commands are repeatable with `.`; Visual-mode selections generally are not.

---

## Macros

| Command          | Effect                                                |
|------------------|-------------------------------------------------------|
| `q{a-z}` ... `q` | Start recording into register `{a-z}`, stop recording |
| `@{a-z}`         | Play back the macro in register `{a-z}`               |
| `@@`             | Repeat the last-played macro                          |
| `{count}@{a-z}`  | Play back `count` times                               |

A macro is a sequence of ordinary verb+noun commands, recorded verbatim. Because macros are stored in named registers (`a`–`z`), you can inspect a recording with `"{a}p`, edit it as plain text in a buffer, and yank it back with `"{a}yy`. For complex repetitive edits that exceed what `.` can do, a macro is the right tool — especially combined with a count or `:normal`.

---

## The second grammar: Ex commands

Vim has a second, older grammar inherited from `ex` (itself descended from `ed`, the original Unix line editor). Around 1976, Bill Joy added a full-screen mode to `ex` — `vi` was literally the `ex` command to enter it. Vim inherits both halves: the Normal-mode verb+noun grammar above, and the Ex command-line grammar below.

```
:[range] command [args]
```

### Ranges

| Range       | Means                                                                      |
|-------------|----------------------------------------------------------------------------|
| `.`         | Current line                                                               |
| `$`         | Last line                                                                  |
| `%`         | Entire file (equivalent to `1,$`)                                          |
| `'<,'>`     | Last Visual selection (auto-inserted when `:` is pressed from Visual mode) |
| `'a,'b`     | Between marks `a` and `b`                                                  |
| `/p1/,/p2/` | From the next match of `p1` through the next match of `p2`                 |

### Commands

| Command                   | Effect                                                      |
|---------------------------|-------------------------------------------------------------|
| `:s/pat/rep/flags`        | Substitute on the current line (use `%` for the whole file) |
| `:g/pat/cmd`              | Run `cmd` on every line matching `pat`                      |
| `:v/pat/cmd`              | Run `cmd` on every line **not** matching `pat`              |
| `:m {dest}` / `:t {dest}` | Move / copy range to after line `{dest}`                    |
| `:normal {keys}`          | Execute Normal-mode keys on every line in the range         |

`:g/TODO/d` reads: "for every line matching `TODO`, delete it." `:g` re-evaluates the pattern per line, making it the closest Vim has to a loop over lines. `:g/^$/d` deletes every blank line in the file.

`:normal` combined with `.` or a macro is powerful: `:%normal .` replays the last change on every line in the file.

---

## Quick self-test

Work through these without looking them up. If any are slow or uncertain, that's the area to practice.

| Task                                                    | Command                             |
|---------------------------------------------------------|-------------------------------------|
| Delete the whole word under cursor                      | `daw`                               |
| Change the contents of `"..."` (cursor anywhere inside) | `ci"`                               |
| Duplicate the current line below                        | `yyp`                               |
| Yank a word and paste it inline somewhere else          | `yiw`, move, `p`                    |
| Delete from cursor to next `;` (inclusive)              | `df;`                               |
| Delete from cursor to just before next `;`              | `dt;`                               |
| Delete 2 bracket levels outward                         | `2da(`                              |
| Delete a line without overwriting the last yank         | `"_dd`                              |
| Paste the last yank after an intervening delete         | `"0p`                               |
| Change every search match, one at a time                | `/pat`, `cgn`, then `n.` repeatedly |
| Delete every blank line in the file                     | `:g/^$/d`                           |
| Uppercase from cursor to end of line                    | `gU$`                               |
| Indent a visual block                                   | `Ctrl-v`, select, `>`               |
| Cancel a pending verb                                   | any verb, then `Esc`                |
| Repeat last change on every line in the file            | `:%normal .`                        |

---

## Source credit

The verb+noun framing and terminology used throughout this document follow the **Learn Vim** guide, specifically the chapter ["Vim Grammar"](https://learnvim.irian.to/basics/vim_grammar) (iggredible, 2020–2021). The Dot Formula terminology is from **Drew Neil, *Practical Vim*** (Pragmatic Bookshelf, 2012). Historical background on the `ed`/`ex`/`vi` lineage is from Wikipedia. Inclusive/exclusive motion semantics are from `:h motion.txt`. All other specifics verified against `:h operator`, `:h text-objects`, `:h Y`, and `:h registers`.

