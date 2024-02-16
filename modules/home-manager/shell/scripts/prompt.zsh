# TODO: Consider adding `set`
# @see https://www.linkedin.com/advice/3/what-some-advantages-disadvantages-using-set-e

# Word style (for backward deletion)
# @see https://stackoverflow.com/questions/444951/zsh-stop-backward-kill-word-on-directory-delimiter
# @see http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Widgets
autoload -U select-word-style
select-word-style bash

# Enable git autocompletion
# @see https://stackoverflow.com/a/58517668
autoload -Uz compinit && compinit

# Case-insentive matching
# @see https://superuser.com/a/1092328
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Utilize vcs_info package
# @see https://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
# @see https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information
# @see https://salferrarello.com/zsh-git-status-prompt/
autoload -Uz vcs_info

zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats ': %F{2}%b%u%c%f'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
# Check for changes
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' ∆'
zstyle ':vcs_info:*' stagedstr ' ≜'

precmd() {
  vcs_info
}

_title_leader() {
  case "$TERM" in
    screen*|tmux*)
      # print "%F{2}○%f"
      print "📦"
      ;;
    *)
      print "$"
      ;;
  esac
}

setopt prompt_subst
PROMPT='%F{4}%~%f${vcs_info_msg_0_} $(_title_leader) '
RPROMPT='%F{2}%n%f %F{4}%W %*%f'

# Colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

