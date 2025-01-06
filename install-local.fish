# Installs the everything needed:
# Run:
# curl --silent --show-error "https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main/install-local.fish" | fish

set TOOLS_URL https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main

wget --quiet "$TOOLS_URL/mac/ghostty--fix.fish" -O - | fish

