# Read a message using the OSX `say` command
#
# In my opinion, the best voices for American English seem to be:
# 'Daniel', 'Karen', 'Rishi', 'Tessa'
TIMER_COMMAND="${TIMER_COMMAND:-say -v Karen --interactive=bold '%s'}"

# Hide tty input while command is running
_timer_tty_off() {
  [ -t 0 ] && stty -echo -icanon time 0 min 0
}

# Reset tty input settings
_timer_tty_on() {
  [ -t 0 ] && stty sane
}

# Helper for `read`
_timer_read_a() {
  [ -n "$ZSH_VERSION" ] && printf "A" || printf "a"
}

# Get the current system time in seconds
_timer_seconds() {
  printf '%d' "$(date +%s)"
}

# Set a timer
#
# string  time    (HH:MM:SS - eg. 01:15:21)
# array   message (Arguments sent to a configured command when timer finishes)
timer() {
  trap _timer_tty_on EXIT
  _timer_tty_off

  TIME=${1// /}

  # Ensure a time is specified
  if [ -z "${TIME}" ]; then
    printf "Please specify a time in 'hh:mm:ss' format\n"
    _timer_tty_on
    return 1
  fi

  # Get current time in seconds
  local START=0
  START=$(_timer_seconds)

  # Get time values
  local SECONDS=0
  SECONDS=$(printf "${TIME}" | awk -F ':' '{ printf $NF + 0 }')

  local MINUTES=0
  MINUTES=$(printf "${TIME}" | awk -F ':' '{ if (NF > 1) printf $(NF-1) + 0; else printf "0" }')

  local HOURS=0
  HOURS=$(printf "${TIME}" | awk -F ':' '{ if (NF > 2) printf $(NF-2) + 0; else printf "0" }')

  # Calculate time in seconds
  local DURATION=$(( SECONDS + (MINUTES * 60) + (HOURS * 60 * 60) ))

  # Calculate end time
  local END=0
  END=$(printf '%d' $((START + DURATION)))

  # Output
  printf "⏰\tStarted:\t%s\n\tEnds:\t\t%s\n" "$(date -r "${START}" '+%D at %T')" "$(date -r "${END}" '+%D at %T')"

  # Show progress
  CURRENT=$(_timer_seconds)
  while [ "${CURRENT}" -lt "${END}" ]; do
    # Calculate remaining time in seconds
    REMAINING=$(( END - CURRENT ))
    printf "\r\033[2K\tRemaining:\t%0.2d:%0.2d:%0.2d\e[K" $(( REMAINING / 60 / 60 )) $(( (REMAINING/60) % 60 )) $(( REMAINING % 60 ))
    sleep 1

    # Update current time
    CURRENT=$(_timer_seconds)
  done

  printf "\r\033[2K\tFinished:\t%s\n" "$(date -r "${END}" '+%D at %T')"

  if [ -n "${TIMER_COMMAND}" ] && [ -n "${2}" ]; then
    eval $(printf "${TIMER_COMMAND}" "${@:2}")
  fi

  _timer_tty_on
}

