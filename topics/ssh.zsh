# topics/ssh.zsh
#
# SSH configuration.
#
# macOS: The system manages the SSH agent via the keychain. After generating a
# key, add it once with:
#   ssh-add --apple-use-keychain ~/.ssh/id_ed25519
#
# Set the following in ~/.ssh/config to persist across reboots:
#   Host *
#     AddKeysToAgent yes
#     UseKeychain yes
#     IdentityFile ~/.ssh/id_ed25519
#
# Linux: Uncomment the block below to auto-start the agent if not running.

# if [[ "$OSTYPE" != darwin* ]]; then
#     if ! ssh-add -l &>/dev/null; then
#         eval "$(ssh-agent -s)" > /dev/null
#         ssh-add "${SSH_KEY:-$HOME/.ssh/id_ed25519}" &>/dev/null
#     fi
# fi
