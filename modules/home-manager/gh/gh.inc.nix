# GitHub CLI — configured to use SSH protocol (matches git SSH signing setup)
{ pkgs, ... }: {
  programs.gh = {
    enable = true;
    settings = {
      editor = "vim";
      git_protocol = "ssh";
      prompt = "enabled";
      pager = "less";
    };
  };
}
