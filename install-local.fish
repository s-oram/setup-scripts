# Installs the everything needed:
# Run:
# curl --silent --show-error "https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main/install-local.fish" | fish

set TOOLS_URL https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main
set SYSTEM mac
set FUNCTIONS_DIR "/.config/fish/functions"

function run_remote_script
  set FILENAME $argv[1]
  wget --quiet "$TOOLS_URL/$SYSTEM/$FILENAME.fish" -O - | fish
end

function copy_remote_fish_func
  set FILENAME $argv[1]
  wget --quiet "$TOOLS_URL/$SYSTEM/fish-functions/$FILENAME.fish" -O ~/$FUNCTIONS_DIR/$FILENAME.fish
end


# Copy Fish functions to local Fish functions directory
copy_remote_fish_func rc


## TODO: Get SSH connection string for host machine we're installing for
## Run install scripts like the ghostty--fix


# Run setup scripts
run_remote_script ghostty--fix


echo ""
echo "Ripcord has been installed. Close and reopen your shell to use"
