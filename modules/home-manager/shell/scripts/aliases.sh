# Custom Aliases
alias c="clear"
alias ll="ls -lAh"
alias cl="c && ls -lAh"
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"

empty() {
  for FILE in "$@"; do
    cat /dev/null > "${FILE}"
  done
}

dictionary () {
  curl dict://dict.org/d:"${1}" | ${PAGER:-less}
}

dotenv() {
  # @see https://stackoverflow.com/a/44364170
  if [ -f ".env" ]; then
    set -o allexport
    source ".env"
    set +o allexport
  fi
}

rmount() {
  local MOUNT_NAME="${1}"
  [ -n "${MOUNT_NAME}" ] || (echo "Provide the mount location" && exit 1)

  # Create mount path
  MOUNT_PATH="${HOME}/.mounts/${MOUNT_NAME}"
  [ -d "${MOUNT_PATH}" ] || mkdir -p "${MOUNT_PATH}"

  rclone mount --daemon "${MOUNT_NAME}:" ${MOUNT_PATH}
}

