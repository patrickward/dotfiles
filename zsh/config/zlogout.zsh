# zsh/config/zlogout.zsh
#
# Loaded when a LOGIN shell exits.
#
# Use this for cleanup tasks on logout:
#   - Stopping background agents (gpg-agent, ssh-agent)
#   - Clearing sensitive environment variables
#   - Logging session end
#
# Keep this fast and non-interactive — the terminal may already be closing.
