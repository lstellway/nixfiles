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

# I originally created these functions because I noticed my remote Docker host connections were very slow.
# Soon after I learned about using persistent SSH connections as a means of improving performance.
# @see https://docs.docker.com/engine/security/protect-access/#ssh-tips
# Keeping these for now just to have.

# Create a docker context to make use of this
# docker context create remote --description "Remote host" --docker "host=unix://${HOME}/.docker/remote.sock"
#
# Use the context
# docker context use remote

# Find all related running processes
docker-remote-pids() {
  local LOCAL_SOCKET="${HOME}/.docker/remote.sock"

  ps -ax | grep ssh | grep "${LOCAL_SOCKET}" | awk '{print $1}'
}

# Cleanup SSH forwarding
docker-remote-cleanup() {
  local LOCAL_SOCKET="${HOME}/.docker/remote.sock"

  # Kill ssh processes
  docker-remote-pids | xargs kill

  # Clean up socket file
  rm -f ${LOCAL_SOCKET}
}

# Connect to a remote Docker host
docker-remote() {
  docker-remote-cleanup

  local HOST="${1}"
  [ -n "${HOST}" ] || (echo "A host must be provided" && exit 1)

  local LOCAL_SOCKET="${HOME}/.docker/remote.sock"
  # trap "rm -f ${LOCAL_SOCKET}" SIGINT SIGTERM

  local REMOTE_SOCKET="${2:-/var/run/docker.sock}"
  ssh -fN -L ${LOCAL_SOCKET}:${REMOTE_SOCKET} ${HOST}
  # rm -f ${LOCAL_SOCKET}
}

# Connect to a remote Docker host deployed with rootless
docker-remote-rootless() {
  local HOST="${1}"
  [ -n "${HOST}" ] || (echo "A host must be provided" && exit 1)
  
  local REMOTE_UID=$(ssh ${HOST} id -u)
  REMOTE_SOCKET="/var/run/user/${REMOTE_UID}/docker.sock"

  docker-remote ${HOST} ${REMOTE_SOCKET}
}

