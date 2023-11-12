[ -e "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"
[ -d "/opt/homebrew/bin" ] && export PATH="${PATH}:/opt/homebrew/bin"

brew-dir() {
  [ -n "${1}" ] || (echo "No package provided" && exit 1)

  PKG="${1}"
  PKG_ROOT=$(brew --cellar "${PKG}")

  [ -d "${PKG_ROOT}" ] || (echo "Package '${PKG}' is not installed" && exit 1)

  PKG_VERSION=$(brew info --json "${PKG}" | jq -r '.[0].installed[0].version')
  [ -d "${PKG_ROOT}/${PKG_VERSION}" ] || (echo "Package '${PKG}' could not be found" && exit 1)

  printf "%s/%s" "${PKG_ROOT}" "${PKG_VERSION}"
}
