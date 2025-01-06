# Installs the everything needed:
# Run:
# curl --silent --show-error "https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main/install-server.bash" | bash

TOOLS_URL="https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main"
FUNCTIONS_DIR="/home/$(whoami)/.config/fish/functions"

sudo apt update
sudo apt-get install wget --yes

# Install Fish
wget --quiet "$TOOLS_URL/ubuntu/fish--install.bash" -O - | bash

# Copy Fish functions to local Fish functions directory
wget --quiet "$TOOLS_URL/ubuntu/fish-functions/rc.fish" -O "$FUNCTIONS_DIR/rc.fish"

echo ""
echo "Setup complete, please exit and restart your SSH session"