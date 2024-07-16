#!/bin/bash

# Prompt for email
read -p "Enter your email for the SSH key: " email

# Check if email is provided
if [ -z "$email" ]; then
  echo "Email is required."
  exit 1
fi

# Prompt for SSH key file path
read -p "Enter the file path for the SSH key (default: ${HOME}/.ssh/id_rsa_github): " ssh_key_path

# Set default if no path is provided
ssh_key_path=${ssh_key_path:-${HOME}/.ssh/id_rsa_github}
ssh_config_path="${HOME}/.ssh/config"

# Generate SSH key
echo ""
echo "Generating SSH key for GitHub..."
ssh-keygen -t rsa -b 4096 -C "$email" -f "$ssh_key_path" -N ""

# Start the SSH agent
echo ""
echo "Starting the SSH agent..."
eval "$(ssh-agent -s)"

# Add SSH key to the agent
echo ""
echo "Adding SSH key to the SSH agent..."
ssh-add "$ssh_key_path"

# Add key to SSH config
echo ""
echo "Updating SSH config..."
{
  echo "Host github.com"
  echo "  HostName github.com"
  echo "  User git"
  echo "  IdentityFile $ssh_key_path"
  echo "  IdentitiesOnly yes"
} >> "$ssh_config_path"

# Display the public key
echo ""
echo "Here is your public key:"
echo ""
cat "${ssh_key_path}.pub"

echo ""
echo "Copy the above public key and add it to your GitHub account at https://github.com/settings/keys"

echo""
echo "SSH Key was created successfully!!!."
