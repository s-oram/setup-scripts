# Installs the everything needed:
# Run:
# curl --silent --show-error "https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main/install-server.bash" | bash

TOOLS_URL="https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main"
FUNCTIONS_DIR="/home/$(whoami)/.config/fish/functions"

sudo apt-get update
sudo apt-get install wget --yes

# Install Fish
wget --quiet "$TOOLS_URL/ubuntu/fish--install.bash" -O - | bash

# Copy Fish functions to local Fish functions directory
mkdir -p $FUNCTIONS_DIR
wget --quiet "$TOOLS_URL/ubuntu/fish-functions/ripcord.fish" -O "$FUNCTIONS_DIR/ripcord.fish"

echo ""
echo "Setup complete"