# topics/composer.zsh
#
# Composer: PHP dependency manager
# https://getcomposer.org
#
# Adds the global vendor bin to PATH so globally-installed tools
# (phpstan, psalm, php-cs-fixer, etc.) are available.
# Install via: https://getcomposer.org/download/

if command -v composer &>/dev/null; then
    path=("$HOME/.composer/vendor/bin" $path)
fi
