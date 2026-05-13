# Git configuration
# Commits are signed with SSH keys (simpler than GPG — no keyring to manage).
# GitHub supports SSH signature verification natively.
{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "lstellway@users.noreply.github.com";
        name = "lstellway";
      };

      # Sign commits using SSH key instead of GPG
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPsof9uDWnEEKaxOQUJmsYfprt4d556JqEgKwKNJCaiq";
      init.defaultBranch = "main";
      # Rebase on pull to keep a linear history
      pull.ff = "only";
      # pull.rebase = true;
      # Automatically set upstream when pushing a new branch
      push.autoSetupRemote = true;
    };
  };
}
