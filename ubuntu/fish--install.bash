# Install `apt-add-repository` command:
sudo apt-get update
sudo apt-get install software-properties-common --yes
sudo apt-get update

# Install Fish v3
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install fish --yes

# Change default shell to Fish
sudo chsh -s $(which fish) $(whoami)
