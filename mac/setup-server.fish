# Sets up Ripcord on the remote host
#
# Usage:
#    ripcord setup-server [user@host]
#
# [user@host] is your SSH connection string
#

#==================#
#  Read Arguments  #
#==================#
set host $argv[1]




#====================#
#  Define Functions  #
#====================#

# When using Ghostty to SSH into another machine, you
# may see errors because those machines do not have
# Ghostty's terminfo entry.
#
# This function copies the local Ghostty terminfo to the
# remove machine
function applyGhosttyFix
  set host $argv[1]
  infocmp -x | ssh $host -- tic -x -
end

# Connect to the remote machine and run install script.
# This does two things:
# 1. Install Fish
# 2. Copy Ripcord function to fish functions directory
function installFishAndRipcord
  set host $argv[1]
  ssh $host 'curl --silent --show-error "https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main/install-server.bash" | bash'
end


#=====================#
#  Run Setup Actions  #
#=====================#


echo "Setup Server for \"$host\""
echo ""


echo "Running Ghostty terminal fix..."
echo ""

applyGhosttyFix $host


echo ""
echo "Running Ripcord install script..."

installFishAndRipcord $host






