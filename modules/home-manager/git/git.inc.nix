{ pkgs, ... }: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "lstellway@users.noreply.github.com";
        name = "lstellway";
      };

      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPsof9uDWnEEKaxOQUJmsYfprt4d556JqEgKwKNJCaiq";
      init.defaultBranch = "develop";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
