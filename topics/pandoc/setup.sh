#!/usr/bin/env bash
# topics/pandoc/setup.sh
#
# Pandoc templates setup.
# Templates are not committed to the repo (too large). Install manually:
#
#   mkdir -p ~/.local/share/pandoc/templates
#
# Eisvogel (LaTeX → PDF):
#   https://github.com/Wandmalfarbe/pandoc-latex-template/releases
#   Download and extract eisvogel.latex to ~/.local/share/pandoc/templates/
#
# After installing, verify with:
#   pandoc --template eisvogel input.md -o output.pdf

. "$DOTFILES/lib/utils.sh"

local templates_dir="${XDG_DATA_HOME:-$HOME/.local/share}/pandoc/templates"

if [ ! -d "$templates_dir" ]; then
    info "Creating pandoc templates directory at $templates_dir"
    mkdir -p "$templates_dir"
    okay "Created $templates_dir"
    warn "Install templates manually — see comments in topics/pandoc/setup.sh"
else
    okay "Pandoc templates directory exists: $templates_dir"
fi
