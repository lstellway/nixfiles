terminal-profile() {
  local THEME="${1:=Basic}"
  local SCRIPT="Application('Terminal').windows[0].currentSettings = Application('Terminal').settingsSets['${THEME}']"
  osascript -l JavaScript -e "$SCRIPT" > /dev/null
}

