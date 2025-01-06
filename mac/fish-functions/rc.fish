function rc -d "Ripcord"
  echo two times33

  function run_remote_script
    # remove function from global scope
    functions -e run_remote_script

    set TOOLS_URL https://raw.githubusercontent.com/s-oram/setup-scripts/refs/heads/main
    set SYSTEM mac
    set CACHE_BREAK (date +%s)
    set FILENAME $argv[1]

    # TODO: Report errors
    wget --quiet "$TOOLS_URL/$SYSTEM/$FILENAME.fish?$CACHE_BREAK" -O - | fish
  end


  # echo $CACHE_BREAK

  switch (count $argv)
    case 0
      echo "Choose the name of the script"
    case '*'
      run_remote_script $argv[(count $argv)]
  end
end
