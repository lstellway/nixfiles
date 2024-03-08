# Setup SSH port
SYSTEM_SSH_PLIST="/System/Library/LaunchDaemons/ssh.plist"

# Find cached SSH connections
ssh-sessions() {
  ps -ax \
    | grep -i '.ssh/control' \
    | grep -vi 'grep' \
    | awk '{print $1}'
}

# Kill cached SSH sessions
ssh-kill-sessions() {
  local SESSIONS=$(ssh-sessions)
  [ -n "${SESSIONS}" ] && ssh-sessions | xargs kill
}

ssh_set_port() {
  # Ensure a port is specified
  if [ -z "$1" ]; then
    printf "No port specified...\n"
    return 1
  fi

  # Ensure original file exists
  if [ ! -f "${SYSTEM_SSH_PLIST}" ]; then
    printf "SSH process definition not found in default location:\n%s\n" "${SYSTEM_SSH_PLIST}"
    return 1
  fi

  PORT="$1"
  FIND="<string>ssh<\/string>"
  REPLACE="<string>${PORT}<\/string>"

  # Unload existing service if a file already exists
  # (errors may occur if service is already unloaded - these can be ignored))
  if [ -f "/Library/LaunchDaemons/ssh.plist" ]; then
    sudo launchctl unload /Library/LaunchDaemons/ssh.plist > /dev/null 2>&1
  fi

  # Copy original SSH process definition and replace the port value
  sudo cp ${SYSTEM_SSH_PLIST} /Library/LaunchDaemons/ssh.plist
  sudo sed -i '' "1,/${FIND}/s/${FIND}/${REPLACE}/" /Library/LaunchDaemons/ssh.plist

  # Load the service
  sudo launchctl load -w /Library/LaunchDaemons/ssh.plist

  printf "SSH port successfully updated to '%s'\nRun the following command to verify the port:\n\n  %s\n" "$1" "sudo lsof -iTCP -sTCP:LISTEN -n -P"
}

