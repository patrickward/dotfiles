# Composer
# --------------------
# Add the global composer vendor bin
if command -v composer > /dev/null; then
  export PATH="$HOME/.config/composer/vendor/bin:$PATH"
fi
