## Rust/Cargo Paths
### Set cargo home and add to path
if command -v cargo > /dev/null; then
  export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
  export PATH="$CARGO_HOME/bin:$PATH"
fi