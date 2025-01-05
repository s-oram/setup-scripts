# Installs the everything needed:
# Run:
# curl --silent --show-error "https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main/ubuntu/install.bash" | bash

# Install `apt-add-repository` command:
sudo apt update
sudo apt-get install software-properties-common --yes
sudo apt update

# Install Fish v3
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish --yes

# Change default shell to Fish
sudo chsh -s $(which fish) $(whoami)

echo "Please restart your SSH session"