function ripcord -d "Ripcord"

  ## Define Functions ##

  function run_remote_script
    functions -e run_remote_script
    set TOOLS_URL https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main
    set SYSTEM ubuntu

    set FILENAME $argv[1]
    set remainingArgs $argv[2..]

    set source "$TOOLS_URL/$SYSTEM/$FILENAME.fish"

    curl --silent --show-error $source | fish -c "source - $remainingArgs"
  end

  ## Main ##

  switch (count $argv)
    case 0
      echo "Choose the name of the script"
    case '*'
      run_remote_script $argv
  end
end
