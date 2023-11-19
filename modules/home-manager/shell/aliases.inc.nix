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

    # Show ports in use
    ports_tcp = "sudo lsof -iTCP -sTCP:LISTEN -n -P";
    ports_udp = "sudo lsof -iUDP -n -P";
  };
}
