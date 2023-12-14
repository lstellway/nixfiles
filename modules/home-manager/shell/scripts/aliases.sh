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
  if [ -f ".env" ]; then
    export $(cat .env | sed 's/ = /=/g' | sed 's/^#.*//g' | xargs)
  fi
}

