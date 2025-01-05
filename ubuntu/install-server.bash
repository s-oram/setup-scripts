# Installs the everything needed:
# Run:
# curl --silent --show-error "https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main/ubuntu/install-server.bash" | bash

TOOLS_URL="https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main/ubuntu"
CACHE_BREAK=$(date +%s)

sudo apt update
sudo apt-get install wget --yes

wget --quiet "$TOOLS_URL/fish--install.bash?$CACHE_BREAK" -O - | bash

echo ""
echo "Setup complete, please exit and restart your SSH session"