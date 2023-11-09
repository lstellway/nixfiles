# Custom Aliases
alias c="clear"
alias ll="ls -lAh"
alias cl="c && ls -lAh"
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"

# Git
alias ga='git add'
alias gd='git diff'
alias gpc='git push origin $(git branch --show-current)'
alias gbn='printf "$(git branch --show-current)" | pbcopy'
# @see https://news.ycombinator.com/item?id=18898523&p=2
alias gitl='git log --pretty=format:"%Cred%h %Cgreen %cd %Cblue%<(14,trunc)%an %Creset %s %Cred %d %Creset" --graph --date=short -20'
# TODO: Consider
# @see https://github.com/paulirish/git-open

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

# Show ports in use
alias ports_tcp="sudo lsof -iTCP -sTCP:LISTEN -n -P"
alias ports_udp="sudo lsof -iUDP -n -P"

