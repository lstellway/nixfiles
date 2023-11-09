{
 home.shellAliases = {
    c = "clear";
    ll = "ls -lAh";
    cl = "clear && ls -lAh";
    ".." = "../";
    "..." = "../../";
    "...." = "../../../";
    "....." = "../../../../";

    # Git
    ga = "git add";
    gd = "git diff";
    gpc = "git push origin $(git branch --show-current)";
    gbn = "printf $(git branch --show-current)";

    # @see https://news.ycombinator.com/item?id=18898523&p=2
    gitl = "git log --pretty=format:\"%Cred%h %Cgreen %cd %Cblue%<(14,trunc)%an %Creset %s %Cred %d %Creset\" --graph --date=short -20";

    # TODO: Consider
    # @see https://github.com/paulirish/git-open

    # Show ports in use
    ports_tcp = "sudo lsof -iTCP -sTCP:LISTEN -n -P";
    ports_udp = "sudo lsof -iUDP -n -P";
  };
}
