---
title: Reference Doc Round-Trip Test
subtitle: Validate styles, tables, and special blocks
author: Devyn
date: September 2026
---

# Heading 1 — Document Title Level

Body text with **bold**, *italic*, ***both***, ~~strikethrough~~, `inline code`,
a [link](https://example.com "with a title"), and a footnote reference[^1].
Check smart quotes here: "curly double," 'single,' and an em-dash — plus ellipsis…

[^1]: This is a footnote. Verify it lands in `Footnote Text` style and sits at
the bottom of the document, superscript intact.

## Heading 2 — Lists

Unordered list with nesting:

- First item
- Second item with `inline code`
  - Nested item
  - Another nested item
- Third item

Ordered list:

1. Step one
2. Step two
   1. Sub-step
   2. Another sub-step
3. Step three

Task list:

- [x] Completed task
- [ ] Pending task
- [ ] Another pending task

## Heading 3 — Blockquotes and Code

A blockquote, one paragraph:

> Simple quote spanning a couple of lines
> to test wrapping and style.

Nested quote:

> Outer level
>
> > Inner level

Code block with a language (syntax highlighting → colored runs in docx):

```go
func md2docx(input string) error {
	out := strings.TrimSuffix(input, ".md") + ".docx"
	return pandoc.Convert(input, out)
}
```

Code block without a language:

```
plain code, no highlighting
  indented content preserved?
```

### Headings 4–6 depth check

#### Heading 4

##### Heading 5

###### Heading 6

## Tables — both flavors

GFM pipe table (simple):

| Column A | Column B | Column C |
|----------|----------|----------|
| alpha    | 1        | `code`   |
| beta     | 2        | **bold** |
| gamma    | 3        | *italic* |

Pandoc grid table (multi-line cells, alignment):

+------------+-------------------+-------------+
| Left       | Center            | Right       |
+============+===================+=============+
| Cell with  | This cell has     | Right-      |
| a long     | wrapped content   | aligned     |
| first col  | across lines.     | content     |
+------------+-------------------+-------------+

Captioned table:

Table: This caption should land in `Table Caption` style.

## Math

Inline math: $E = mc^2$ and a display equation:

$$\int_{-\infty}^{\infty} e^{-x^2}\,dx = \sqrt{\pi}$$

## Images

A standalone image with a caption:

![Figure caption — should land in `Image Caption` style](test-image.png){width=3in}

https://picsum.photos/536/354

## Definition List

Pandoc
:   A universal document converter with writers for dozens of formats.

Reference doc
:   A docx whose named styles define the appearance of converted output.

## Horizontal rule and misc

---

Hard line break test\
this should be on the next line.

Superscript^sup^, subscript~sub~, and a raw HTML fragment: <!-- should be ignored -->.

## Long-wrapped paragraph for readability check

This is deliberately a long paragraph so you can verify how `Body Text`
and `First Paragraph` styles handle justification, spacing after
paragraphs, line height, and hyphenation when the reference document's
settings propagate through the conversion. If this paragraph looks
consistent with the rest of the body text — neither cramped nor oddly
spaced — the reference doc round-trip is behaving correctly and you can
trust it for real documents.
