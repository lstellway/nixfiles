{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userEmail = "lstellway@users.noreply.github.com";
    userName = "lstellway";
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPsof9uDWnEEKaxOQUJmsYfprt4d556JqEgKwKNJCaiq";
      init.defaultBranch = "develop";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
