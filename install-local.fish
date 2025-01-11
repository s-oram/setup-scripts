# Installs the everything needed:
# Run:
# curl --silent --show-error "https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main/install-local.fish" | fish

set TOOLS_URL https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main
set SYSTEM mac
set FUNCTIONS_DIR "/.config/fish/functions"

function copy_remote_fish_func
  set FILENAME $argv[1]
  set output ~/$FUNCTIONS_DIR/$FILENAME.fish
  set source "$TOOLS_URL/$SYSTEM/fish-functions/$FILENAME.fish"
  curl --silent --show-error -o $output $source
  #wget --quiet "$TOOLS_URL/$SYSTEM/fish-functions/$FILENAME.fish" -O
end


# Copy Fish functions to local Fish functions directory
copy_remote_fish_func ripcord

echo ""
echo "Ripcord has been installed. Close and reopen your shell to use"
