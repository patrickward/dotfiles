#!/usr/bin/env zsh
# topics/fonts/setup.sh
#
# Downloads and installs open-source coding fonts from their GitHub releases.
# Fonts are installed to ~/Library/Fonts (macOS only).
# Sourced by `zdot setup`, which provides info/okay/warn and $DOTFILES.

is_macos || { warn "Font installation is macOS-only — skipping"; return 0; }

FONTS_DIR="$HOME/Library/Fonts"
mkdir -p "$FONTS_DIR"

# ---------------------------------------------------------------------------
# github_asset_url: resolve the download URL for a release asset
#
# Uses the GitHub releases API. No jq dependency — grep/sed only.
#
# Arguments:
#   repo     — GitHub owner/repo (e.g. "JetBrains/JetBrainsMono")
#   pattern  — grep pattern that uniquely identifies the desired zip asset
# ---------------------------------------------------------------------------
github_asset_url() {
    local repo="$1"
    local pattern="$2"
    curl -fsSL "https://api.github.com/repos/${repo}/releases/latest" \
        | grep '"browser_download_url"' \
        | grep "$pattern" \
        | head -1 \
        | sed 's/.*"browser_download_url": "\(.*\)".*/\1/'
}

# ---------------------------------------------------------------------------
# install_font: download a zip from GitHub and install all .ttf/.otf files
#
# Skips installation if a file matching the sentinel glob already exists in
# ~/Library/Fonts, so re-running setup is safe (idempotent).
#
# Arguments:
#   name      — display name for log messages
#   repo      — GitHub owner/repo
#   pattern   — grep pattern to identify the zip asset
#   sentinel  — glob to check for existing installation (e.g. "FiraCode-*.ttf")
# ---------------------------------------------------------------------------
install_font() {
    local name="$1"
    local repo="$2"
    local pattern="$3"
    local sentinel="$4"

    if ls "$FONTS_DIR"/$sentinel 2>/dev/null | head -1 | grep -q .; then
        okay "Already installed: $name"
        return 0
    fi

    info "Installing $name..."

    local url
    url=$(github_asset_url "$repo" "$pattern")

    if [[ -z "$url" ]]; then
        warn "Could not find download URL for $name — skipping"
        return 1
    fi

    local tmpdir
    tmpdir=$(mktemp -d)
    trap "rm -rf $tmpdir" EXIT

    if ! curl -fsSL "$url" -o "$tmpdir/font.zip"; then
        warn "Download failed for $name — skipping"
        return 1
    fi

    unzip -q "$tmpdir/font.zip" -d "$tmpdir/extracted"

    local count=0
    while IFS= read -r font; do
        cp "$font" "$FONTS_DIR/"
        (( count++ ))
    done < <(find "$tmpdir/extracted" \( -name "*.ttf" -o -name "*.otf" \) 2>/dev/null)

    rm -rf "$tmpdir"
    trap - EXIT

    if (( count > 0 )); then
        okay "Installed $name ($count files)"
    else
        warn "No font files found in archive for $name"
    fi
}

# ---------------------------------------------------------------------------
# Fonts
# ---------------------------------------------------------------------------
install_font "JetBrains Mono" \
    "JetBrains/JetBrainsMono" \
    "JetBrainsMono-" \
    "JetBrainsMono-*.ttf"

install_font "Fira Code" \
    "tonsky/FiraCode" \
    "Fira_Code_v" \
    "FiraCode-*.ttf"

install_font "Cascadia Code" \
    "microsoft/cascadia-code" \
    "CascadiaCode-" \
    "CascadiaCode-*.ttf"
