# Experiencing an issue where Docker is constantly trying to connect to remote hosts
# @see https://forums.docker.com/t/docker-continuously-making-unnecessary-ssh-connections-to-remote-servers/136132
# List process IDs where Docker is connecting to remote environment
docker-ssh-sessions() {
  ps -ax \
    | grep -iE 'ssh.*docker system dial-stdio' \
    | grep -vi 'grep' \
    | awk '{print $1}'
}

# Kill processes
docker-kill-ssh-sessions() {
  local SESSIONS=$(docker-ssh-sessions)

  [ -n "${SESSIONS}" ] \
    && docker-ssh-sessions | xargs kill
}

RANCHER_DESKTOP_BIN_DIR="${HOME}/.rd/bin"
[ -d "${RANCHER_DESKTOP_BIN_DIR}" ] && export PATH="${PATH}:${RANCHER_DESKTOP_BIN_DIR}"

