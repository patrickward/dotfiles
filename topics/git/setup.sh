#!/usr/bin/env bash
# topics/git/setup.sh

. "$DOTFILES/lib/utils.sh"

# ---------------------------------------------------------------------------
# gitconfig.local: machine-specific identity (name, email, templatedir)
# ---------------------------------------------------------------------------
if [ ! -f "$HOME/.gitconfig.local" ]; then
    info "Creating ~/.gitconfig.local from template..."
    cp "$DOTFILES/topics/git/gitconfig.local.template" "$HOME/.gitconfig.local"
    warn "Edit ~/.gitconfig.local to set your name and email"
else
    okay "~/.gitconfig.local already exists (skipping)"
fi

# ---------------------------------------------------------------------------
# Git hook templates: copied to ~/.config/git/templates/hooks/
# The pre-commit hook enforces that user.email is set per-repo.
# gitconfig.local points git at this directory via init.templatedir.
# ---------------------------------------------------------------------------
local hooks_dir="$HOME/.config/git/templates/hooks"

if [ ! -d "$hooks_dir" ]; then
    info "Installing git hook templates to $hooks_dir..."
    mkdir -p "$hooks_dir"
    cp "$DOTFILES/topics/git/templates/hooks/pre-commit" "$hooks_dir/pre-commit"
    chmod +x "$hooks_dir/pre-commit"
    okay "Git hook templates installed"
else
    okay "Git hook templates already at $hooks_dir"
fi
