# Git
alias ga="git add";
alias gd="git diff";
alias gpc="git push origin $(git branch --show-current)";
alias gpo="git pull origin $(git branch --show-current)";
alias gfo="git fetch origin $(git branch --show-current)";
alias gbn="printf $(git branch --show-current)";

# @see https://news.ycombinator.com/item?id=18898523&p=2
alias gitl="git log --pretty=format:\"%Cred%h %Cgreen %cd %Cblue%<(14,trunc)%an %Creset %s %Cred %d %Creset\" --graph --date=short -20";

# TODO: Consider
# @see https://github.com/paulirish/git-open

