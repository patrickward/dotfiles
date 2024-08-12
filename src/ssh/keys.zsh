# Function to check if the SSH key is already added
ssh_key_is_added() {
    ssh-add -l | grep -q "$1"
}

# Path to SSH private key
SSH_KEY="$HOME/.ssh/id_rsa"

# Add SSH key to the agent
if [[ -f "$SSH_KEY" ]]; then
    if ! ssh_key_is_added "$SSH_KEY"; then
        # Start the ssh-agent in the background
        eval "$(ssh-agent -s)" > /dev/null
        # Add your SSH key, suppressing normal output
        ssh-add "$SSH_KEY" > /dev/null 2>&1 || echo "Error adding SSH key: $SSH_KEY"
    fi
else
    echo "SSH key not found: $SSH_KEY"
fi

