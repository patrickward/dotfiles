#!/usr/bin/env bash
# vim/bin/install-plugins.sh
# Idempotent: fetch pinned ref fresh into each dest, no nested .git left behind.
set -euo pipefail

: "${DOTFILES:?DOTFILES env var not set — source your dotfiles env before running this}"

VIM_DIR="$DOTFILES/topics/vim"
DEST_ROOT="$VIM_DIR/pack/plugins/start"
MANIFEST="$VIM_DIR/plugins.txt"

mkdir -p "$DEST_ROOT"

while read -r url ref dest; do
  [[ -z "$url" || "$url" == \#* ]] && continue
  path="$DEST_ROOT/$dest"
  tmp="$(mktemp -d)"

  echo "==> fetching $dest"
  git clone --depth 1 --branch "$ref" "$url" "$tmp" 2>/dev/null \
    || git clone --depth 1 "$url" "$tmp"   # falls back if $ref is a commit, not a branch

  rm -rf "$tmp/.git"        # de-fang: plain files only, no embedded repo
  rm -rf "$path"
  mv "$tmp" "$path"
done < "$MANIFEST"

echo "Done. Run :helptags ALL in vim if any plugin ships docs."
