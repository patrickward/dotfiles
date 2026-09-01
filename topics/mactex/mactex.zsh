# Topic: mactex (TeX Live via Homebrew cask, no GUI)

# Guard: bail early if the cask isn't installed
if ! brew list --cask --versions mactex-no-gui &>/dev/null; then
  echo "Fuck it, I'm out"
  return 0
fi

# TeX Live binaries live outside Homebrew's prefix, managed by the pkg
if [[ -d "/Library/TeX/texbin" ]]; then
  path=("/Library/TeX/texbin" $path)
fi

# Unset when topic is unloaded (matches your other topics' lifecycle)
unset_topic mactex() {
  path=(${path#/Library/TeX/texbin})
}
