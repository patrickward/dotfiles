# topics/rust.zsh
#
# Rust toolchain configuration.
#
# Installed via mise, which wraps rustup under the hood — you get .mise.toml
# pinning on top of the standard toolchain manager:
#   mise use --global rust@stable
# Toolchain targets still go through rustup directly:
#   rustup target add wasm32-unknown-unknown
#
# ~/.cargo/env (adds ~/.cargo/bin to PATH) is sourced in zshenv.zsh for all shells.
# No further PATH setup is needed here.
#
# If you use a non-default CARGO_HOME or RUSTUP_HOME, set them in ~/.localrc:
#   export CARGO_HOME="$HOME/.cargo"
#   export RUSTUP_HOME="$HOME/.rustup"
