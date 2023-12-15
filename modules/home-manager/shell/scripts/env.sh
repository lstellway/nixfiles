# Load environment variables
# @see https://stackoverflow.com/a/44364170
if [ -f "${HOME}/.env" ]; then
  set -o allexport
  source "${HOME}/.env"
  set +o allexport
fi

