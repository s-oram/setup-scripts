## Pre-define global variables ##

set server_ip4 undefined
set server_name undefined



## Define functions ##

function yes_to_continue
  while true
    set message $argv[1] 'Continue? [y/N]'

    read -l -P {$message[1]}" " confirm

    switch $confirm
      case Y y
        return 0
      case '' N n
        exit
    end
  end
end


# The server signature will have changed, so we need to remove it from
# our `known_hosts` file.
function remove_old_server_from_known_hosts --no-scope-shadowing
  echo "Removing server IP address from known hosts"
  echo ""
  set file_path ~/.ssh/known_hosts
  set sed_command /^$(string replace --all . '\.' $server_ip4)/d
  if test -f $file_path
    sed -i '' $sed_command $file_path
    echo "Lines starting with $server_ip4 have been removed from $file_path"
  else
    echo "Error: $file_path does not exist"
  end
end

# Update `~/.ssh/config` to name our server. This allows us
# to connect to the server with a command like `ssh root@web-server` instead
# of `ssh root@123.123.123.123`.
function updateSSHConfig --no-scope-shadowing
  echo "Open `~/.ssh/config` and update the `Host green` section with"
  echo ""
  echo "```"
  echo "Host green"
  echo "  HostName $server_ip4"
  echo "  User root"
  echo "  IdentityFile ~/.ssh/id_rsa"
  echo "```"
  echo ""

  subl --new-window ~/.ssh/config
end



# Function to check if sshpass is installed
function check_sshpass
    # Check if sshpass is installed
    if not type -q sshpass
        echo "sshpass is not installed. Installing via Brew..."

        # Check if Homebrew is installed
        if not type -q brew
            echo "Homebrew is not installed. Please install Homebrew first."
            return 1
        end

        # Install sshpass
        brew install sshpass

        if test $status -eq 0
            echo "sshpass installed successfully."
        else
            echo "Failed to install sshpass."
            return 1
        end
    end
end


# Function to connec to the server for the first time
function connect_first_time
  echo "Connecting to the server for the first time"
  echo ""
  # Provide the server password to `sshpass` to avoid manually typing it in
  # after connecting.
  # After connecting we immediately exit.
  # The goal here is to update our `~/.shh/known_hosts` with the new
  # server signature.
  set --export SSHPASS $server_password
  sshpass -e ssh -o StrictHostKeyChecking=accept-new root@$server_name exit

  # Connect for the first time, updating our `~/.shh/known_hosts` file
  # ssh -o StrictHostKeyChecking=accept-new root@$server_name -- exit;

  # ssh-copy-id -i ~/.ssh/id_rsa.pub root@your_server_ip
end

# Copy ssh key to server. This allows us to connect without a password.
function copy_key_to_server
  echo "Copying key to server..."
  echo ""

  set --export SSHPASS $server_password
  sshpass -e ssh-copy-id -i ~/.ssh/id_rsa.pub root@$server_name

  echo "Connecting to server with key..."
  echo ""

  set SERVER root@$server_name

  if ssh -o BatchMode=yes $SERVER true
    echo "SSH connection to $SERVER successful."
  else
    echo "Failed to connect to $SERVER via SSH."
    exit 1
  end
end

function disable_password_authentication
  # Variables
  set file_path "/etc/ssh/sshd_config"
  set find_line "#PasswordAuthentication yes"
  set replace_line "PasswordAuthentication no"
  set temp_file (mktemp) # Temporary file on local system

  set ssh_command "grep -q '$find_line' '$remote_file_path' && sed 's|$find_line|$replace_line|' '$remote_file_path' > '$temp_file' && mv '$temp_file' '$remote_file_path' || echo 'Error: Line not found.' >&2"

  # SSH into the remote server and execute the command
  ssh root@$server_name $ssh_command

  # Check if the command succeeded
  if test $status -ne 0
      echo "Error: Line not found or other issue occurred on the server." >&2
      exit 1
  else
      echo "Line replaced successfully on remote server."
  end
end

function confirm_password_authentication_is_disabled
  set -l TARGET root@$server_name

  # Try to connect with password authentication explicitly enabled
  if not ssh -o BatchMode=yes -o PasswordAuthentication=yes -o PubkeyAuthentication=no $TARGET exit >/dev/null 2>&1
      echo "Password authentication is disabled on $TARGET"
  else
      echo "WARNING: Password authentication might be enabled on $TARGET"
      return 1
  end

  # Double-check by attempting to use keyboard-interactive auth
  if not ssh -o BatchMode=yes -o PasswordAuthentication=no -o PubkeyAuthentication=no -o KbdInteractiveAuthentication=yes $TARGET exit >/dev/null 2>&1
      echo "Keyboard-interactive authentication is also disabled on $TARGET"
  else
      echo "WARNING: Keyboard-interactive authentication might be enabled on $TARGET"
      return 1
  end
end



## Execute script  ##

updateSSHConfig
yes_to_continue
remove_old_server_from_known_hosts
check_sshpass
connect_first_time
copy_key_to_server
disable_password_authentication
confirm_password_authentication_is_disabled
