function rc -d "Ripcord"
  switch (count $argv)
    case 0
      echo "Choose the name of the script"
    case '*'
      run_remote_script $argv[(count $argv)]
  end
end


function run_remote_script
  set TOOLS_URL https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main
  set SYSTEM ubuntu
  set CACHE_BREAK (date +%s)
  set FILENAME $argv[1]

  wget --quiet "$TOOLS_URL/$SYSTEM/$FILENAME.fish?$CACHE_BREAK" -O - | fish
end

