{
  # Configure shell aliases
  home.shellAliases = {
    c = "clear";
    ll = "ls -lAh";
    cl = "clear && ls -lAh";
    ".." = "cd ../";
    "..." = "cd ../../";
    "...." = "cd ../../../";
    "....." = "cd ../../../../";

    # Tmux
    tmux-dir = "tmux new -s \"$(basename $(dirname $PWD))/$(basename $PWD)\"";

    # Show ports in use
    ports_tcp = "sudo lsof -iTCP -sTCP:LISTEN -n -P";
    ports_udp = "sudo lsof -iUDP -n -P";
  };
}
