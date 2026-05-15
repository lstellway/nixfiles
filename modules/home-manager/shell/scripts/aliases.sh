# Custom Aliases
alias c="clear"
alias ll="ls -lAh"
alias cl="c && ls -lAh"
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"

dictionary () {
  curl dict://dict.org/d:"${1}" | ${PAGER:-less}
}

dotenv() {
  ENV_FILE="${1:-.env}"
  # @see https://stackoverflow.com/a/44364170
  if [ -f "${ENV_FILE}" ]; then
    set -o allexport
    source "${ENV_FILE}"
    set +o allexport
  fi
}

empty() {
  for FILE in "$@"; do
    cat /dev/null > "${FILE}"
  done
}

fastrm() {
  local target="${1}"
  if [ -z "$target" ]; then
    echo "Usage: fastrm <path>" >&2
    return 1
  fi

  # Create temporary directories
  local empty staging
  empty=$(mktemp -d)
  staging=$(mktemp -d)

  # Move files to temporary directory
  # Instantly clears up current workdir
  mv "$target" "$staging/"

  # Sync empty directory recursively
  rsync -a --delete "$empty/" "$staging/"

  # Clean up temporary directories
  rm -rf "$empty" "$staging"
}

rmount() {
  local MOUNT_NAME="${1}"
  [ -n "${MOUNT_NAME}" ] || (echo "Provide the mount location" && exit 1)

  # Create mount path
  MOUNT_PATH="${HOME}/.mounts/${MOUNT_NAME}"
  [ -d "${MOUNT_PATH}" ] || mkdir -p "${MOUNT_PATH}"

  rclone mount --daemon "${MOUNT_NAME}:" ${MOUNT_PATH}
}

yarn-dupes() {
  if [ -z "$1" ]; then
    echo "Usage: yarn-dupes <lock-path>" >&2
    return 1
  fi

  grep '^"' "$1" \
    | sed 's/.*"\(@\{0,1\}[^@]*\)@.*/\1/' \
    | sort | uniq -d
}

yarn-diff() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: yarn-diff <lock-path-1> <lock-path-2>" >&2
    return 1
  fi

  diff <(yarn-dupes "$1") <(yarn-dupes "$2")
}

