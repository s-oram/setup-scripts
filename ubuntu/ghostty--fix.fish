# When using Ghostty to SSH into another machine, you
# may see errors because those machines do not have
# Ghostty's terminfo entry.
#
# This script copies the local Ghostty terminfo to the
# remove machine

# TODO: Replace Orb with server name

infocmp -x | ssh orb -- tic -x -