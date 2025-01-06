# Installs the everything needed:
# Run:
# curl --silent --show-error "https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main/install-local.fish" | fish

set TOOLS_URL https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main
set CACHE_BREAK date +%s

set FUNCTIONS_DIR ~/.config/fish/functions

wget "$TOOLS_URL/mac/fish-functions/rc.fish?token=$CACHE_BREAK" -O "$FUNCTIONS_DIR/rc.fish"

## wget --quiet "$TOOLS_URL/ghostty--fix.fish?$CACHE_BREAK" -O - | fish

