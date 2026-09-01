# topics/pandoc.zsh
#
# Pandoc-based document conversion functions.
# Requires: pandoc

# Templates directory for mkpdf (Eisvogel LaTeX templates)
export MKPDF_TEMPLATES="$HOME/code/templates/mkpdf"

# ---------------------------------------------------------------------------
# mkpdf <brand> <preset> <file.md> [output.pdf]
# ---------------------------------------------------------------------------
# Converts markdown to PDF via pandoc. Run `mkpdf` alone for usage.
# Brand and preset files are composed from $MKPDF_TEMPLATES/.
#
# For variables in the templates, see:
# https://github.com/enhuiz/eisvogel#custom-template-variables
# https://pandoc.org/MANUAL.html#variables-for-latex
mkpdf() {
  emulate -L zsh
  local T="$MKPDF_TEMPLATES"
  local usage="Usage: mkpdf <brand> <preset> <file.md> [output.pdf]
  brand   - name in $T/brands/<brand>.yaml
  preset  - name in $T/presets/<preset>.yaml
  file    - path to markdown source
  output  - output PDF path (optional, default: <file>.pdf)

Examples:
  mkpdf mycompany memo notes.md
  mkpdf company1 proposal RFP-draft.md
  mkpdf company2 report Q3-status.md custom-name.pdf"

  # --- arg count ---
  if [[ $# -lt 3 || $# -gt 4 ]]; then
    print -u2 "$usage"
    return 1
  fi

  local brand="$1" preset="$2" file="$3" output=""
  [[ $# -eq 4 ]] && output="$4"

  # --- prerequisites ---
  local -a missing
  (( ${+commands[pandoc]} ))  || missing+=("pandoc")
  (( ${+commands[xelatex]} )) || missing+=("xelatex")

  if (( ${#missing} )); then
    print -u2 "Missing prerequisites: ${missing[*]}"
    print -u2 "Install with: brew install pandoc && brew install --cask mactex-no-gui"
    return 1
  fi

  # Check for missing templates directory
  if [[ ! -d "$T" ]]; then
    print -u2 "Templates directory not found: $T"
    print -u2 "Create it and add your Eisvogel template and brand/preset YAML files."
    print -u2 ""
    print -u2 "$usage"
    return 1
  fi

  # Optional: include custom color definitions
  local colors_file="$T/colors.tex"
  local include_header=()
  [[ -f "$colors_file" ]] && include_header=("--include-in-header" "$colors_file")

  # --- template and config files ---

  local tpl="$T/eisvogel.latex"
  local brand_yaml="$T/brands/$brand.yaml"
  local preset_yaml="$T/presets/$preset.yaml"

  local -a notfound
  [[ -f "$tpl" ]]         || notfound+=("$tpl")
  [[ -f "$brand_yaml" ]]  || notfound+=("$brand_yaml")
  [[ -f "$preset_yaml" ]] || notfound+=("$preset_yaml")

  if (( ${#notfound} )); then
    print -u2 "Missing files:"
    print -u2 "  ${notfound[*]}"
    print -u2 ""
    print -u2 "$usage"
    return 1
  fi

  # --- source file ---
  if [[ ! -f "$file" ]]; then
    print -u2 "Source file not found: $file"
    return 1
  fi

  # --- output file ---
  [[ -z "$output" ]] && output="${file:r}.pdf"

  # --- run ---
  pandoc "$file" \
    "${include_header[@]}" \
    --template="$tpl" \
    --pdf-engine=xelatex \
    --metadata-file="$brand_yaml" \
    --metadata-file="$preset_yaml" \
    -o "$output" \
    && print "Created: $output" \
    || { print -u2 "pandoc failed"; return 1 }
}

# ---------------------------------------------------------------------------
# mkdocx [--open] [--template <file.docx>] <file.md> [output.docx]
# ---------------------------------------------------------------------------
# Converts markdown to DOCX via pandoc. Run `mkdocx` alone for usage.
# With --open, opens the result in Apple Pages (or default DOCX handler).
# With --template, uses a custom reference DOCX file.
# If no --template is provided, uses reference.docx from $MKPDF_TEMPLATES if found,
# otherwise falls back to pandoc's default template.
mkdocx() {
  emulate -L zsh
  local T="$MKPDF_TEMPLATES"
  local usage="Usage: mkdocx [--open] [--template <file.docx>] <file.md> [output.docx]"

  local open_flag=false
  local file=""
  local output=""
  local template=""

  # Parse arguments
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --open)
        open_flag=true
        shift
        ;;
      --template)
        if [[ -z "$template" && -n "$2" && "$2" != -* ]]; then
          template="$2"
          shift 2
        else
          print -u2 "--template requires a file argument"
          print -u2 "$usage"
          return 1
        fi
        ;;
      -*)
        print -u2 "Unknown flag: $1"
        print -u2 "$usage"
        return 1
        ;;
      *)
        if [[ -z "$file" ]]; then
          file="$1"
        elif [[ -z "$output" ]]; then
          output="$1"
        else
          print -u2 "Too many arguments"
          print -u2 "$usage"
          return 1
        fi
        shift
        ;;
    esac
  done

  if [[ -z "$file" ]]; then
    print -u2 "$usage"
    return 1
  fi

  # --- prerequisites ---
  if ! (( ${+commands[pandoc]} )); then
    print -u2 "Missing prerequisite: pandoc"
    print -u2 "Install with: brew install pandoc"
    return 1
  fi

  # --- source file ---
  if [[ ! -f "$file" ]]; then
    print -u2 "Source file not found: $file"
    return 1
  fi

  # --- output file ---
  if [[ -z "$output" ]]; then
    output="${file:r}.docx"
  fi

  # --- reference template ---
  # If --template was provided, use it
  if [[ -n "$template" ]]; then
    if [[ ! -f "$template" ]]; then
      print -u2 "Template file not found: $template"
      return 1
    fi
  else
    # Use reference.docx from $MKPDF_TEMPLATES if it exists
    if [[ -f "$T/reference.docx" ]]; then
      template="$T/reference.docx"
    fi
  fi

  # --- run ---
  local pandoc_args=("$file" -o "$output")
  [[ -n "$template" ]] && pandoc_args+=("--reference-doc=""$template")

  pandoc "${pandoc_args[@]}" \
    && print "Created: $output" \
    || { print -u2 "pandoc failed"; return 1 }

  # --- open in Pages ---
  if $open_flag; then
    open "$output"
  fi
}

# ---------------------------------------------------------------------------
# md2html [--open] [--template <file.html>] <file.md> [output.html]
# ---------------------------------------------------------------------------
# Converts markdown to standalone, self-contained HTML. Run `md2html` alone for usage.
# With --open, opens the result in the default browser.
# With --template, uses a custom HTML template.
# Output defaults to <file>.html if not specified.
#
# Examples:
#   md2html README.md
#   md2html --open draft.md
#   md2html --template custom.html index.md output/index.html
md2html() {
  emulate -L zsh
  local usage="Usage: md2html [--open] [--template <file.html>] <file.md> [output.html]"

  local open_flag=false
  local file="" output="" template=""

  # Parse args (similar to your mkdocx pattern)
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --open) open_flag=true; shift ;;
      --template)
        if [[ -z "$template" && -n "$2" && "$2" != -* ]]; then
          template="$2"; shift 2
        else
          print -u2 "--template requires a file argument"; print -u2 "$usage"; return 1
        fi ;;
      -*) print -u2 "Unknown flag: $1"; print -u2 "$usage"; return 1 ;;
      *)
        if [[ -z "$file" ]]; then file="$1"
        elif [[ -z "$output" ]]; then output="$1"
        else print -u2 "Too many arguments"; print -u2 "$usage"; return 1
        fi; shift ;;
    esac
  done

  [[ -z "$file" ]] && { print -u2 "$usage"; return 1 }
  (( ${+commands[pandoc]} )) || { print -u2 "Missing: pandoc"; return 1 }
  [[ -f "$file" ]] || { print -u2 "File not found: $file"; return 1 }

  [[ -z "$output" ]] && output="${file:r}.html"
  [[ -n "$template" && ! -f "$template" ]] && { print -u2 "Template not found: $template"; return 1 }

  local args=("$file" -o "$output" --standalone --self-contained)
  [[ -n "$template" ]] && args+=("--template=$template")

  pandoc "${args[@]}" && print "Created: $output" || { print -u2 "pandoc failed"; return 1 }
  $open_flag && open "$output"
}

# ---------------------------------------------------------------------------
# html2md <file.html> [output.md]
# ---------------------------------------------------------------------------
# Converts HTML to markdown. Run `html2md` alone for usage.
#
# Examples:
#   html2md document.html
#   html2md archive/page.html extracted.md
html2md() {
  emulate -L zsh
  local usage="Usage: html2md <file.html> [output.md]"

  [[ $# -lt 1 || $# -gt 2 ]] && { print -u2 "$usage"; return 1 }
  (( ${+commands[pandoc]} )) || { print -u2 "Missing: pandoc"; return 1 }

  local file="$1" output="${2:-${1:r}.md}"
  [[ -f "$file" ]] || { print -u2 "File not found: $file"; return 1 }

  pandoc "$file" -f html -t markdown -o "$output" \
    && print "Created: $output" \
    || { print -u2 "pandoc failed"; return 1 }
}

# ---------------------------------------------------------------------------
# docx2md <file.docx> [output.md]
# ---------------------------------------------------------------------------
# Converts DOCX (Word) to markdown. Run `dox2md` alone for usage.
#
# Examples:
#   docx2md Report.docx
#   docx2md client-draft.docx draft.md
docx2md() {
  emulate -L zsh
  local usage="Usage: docx2md <file.docx> [output.md]"

  [[ $# -lt 1 || $# -gt 2 ]] && { print -u2 "$usage"; return 1 }
  (( ${+commands[pandoc]} )) || { print -u2 "Missing: pandoc"; return 1 }

  local file="$1" output="${2:-${1:r}.md}"
  [[ -f "$file" ]] || { print -u2 "File not found: $file"; return 1 }

  pandoc "$file" -f docx -t markdown -o "$output" \
    && print "Created: $output" \
    || { print -u2 "pandoc failed"; return 1 }
}