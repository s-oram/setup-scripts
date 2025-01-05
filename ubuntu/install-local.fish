# Installs the everything needed:
# Run:
# curl --silent --show-error "https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main/ubuntu/install-local.bash" | bash

set TOOLS_URL https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main/ubuntu
set CACHE_BREAK date +%s

wget --quiet --show-progress "$TOOLS_URL/ghostty--fix.fish?$CACHE_BREAK" -O - | fish