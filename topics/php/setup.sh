#!/usr/bin/env bash
# topics/php/setup.sh
# Configure global PHP development extensions that Composer cannot install.
#
# Depends on:
#   - php installed via Brewfile
#   - native libraries required by PECL extensions installed via Brewfile
#     e.g. imagemagick for ext-imagick

set -euo pipefail

is_macos || return 0

if ! command -v brew &>/dev/null; then
  warn "Homebrew not found — run brew bundle first"
  return 1
fi

if ! command -v php &>/dev/null; then
  warn "php not found — run brew bundle first"
  return 1
fi

if ! command -v pecl &>/dev/null; then
  warn "pecl not found — expected it to be available with Homebrew php"
  return 1
fi

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

brew_formula_installed() {
  brew --prefix "$1" &>/dev/null
}

php_extension_loaded() {
  php -r 'exit(extension_loaded($argv[1]) ? 0 : 1);' "$1"
}

pecl_package_installed() {
  pecl list "$1" &>/dev/null
}

install_pecl_extension() {
  local extension="$1"
  local package="${2:-$1}"

  if php_extension_loaded "$extension"; then
    okay "PHP extension ${extension} already loaded"
    return 0
  fi

  if pecl_package_installed "$package"; then
    warn "PECL package ${package} is installed, but PHP extension ${extension} is not loaded"
    warn "Verify with: php -r 'var_dump(extension_loaded(\"${extension}\"));'"
    warn "Check config with: php --ini"
    return 0
  fi

  info "Installing PECL package ${package}"
  pecl install "$package"
  PHP_EXTENSIONS_CHANGED=true

  if php_extension_loaded "$extension"; then
    okay "PHP extension ${extension} installed and loaded"
  else
    warn "Installed PECL package ${package}, but PHP extension ${extension} is not loaded"
    warn "Verify with: php -r 'var_dump(extension_loaded(\"${extension}\"));'"
    warn "Check config with: php --ini"
  fi
}

# ---------------------------------------------------------------------------
# Native dependencies
# ---------------------------------------------------------------------------

if brew_formula_installed "imagemagick"; then
  okay "imagemagick formula installed"
else
  warn "imagemagick formula not found — ext-imagick may fail to build"
  warn "Add brew \"imagemagick\" to topics/homebrew/Brewfile, then run brew bundle"
fi

# ---------------------------------------------------------------------------
# Global PHP extensions
# ---------------------------------------------------------------------------
# Keep this list conservative. Project PHP libraries belong in composer.json.
# This list is for native PHP extensions that Composer can require as ext-*,
# but cannot install by itself.

PHP_EXTENSIONS_CHANGED=false

install_pecl_extension "imagick"
install_pecl_extension "redis"

# ---------------------------------------------------------------------------
# Restart php-fpm if extension state changed
# ---------------------------------------------------------------------------

if [[ "$PHP_EXTENSIONS_CHANGED" == true ]]; then
  if brew services list | grep -qE "^php\s+started"; then
    info "Restarting php-fpm so FPM picks up extension changes"
    brew services restart php
  else
    info "Starting php-fpm"
    brew services start php
  fi
else
  okay "PHP extensions already up to date"
fi

info "PHP setup complete."