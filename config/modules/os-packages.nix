{ lib, pkgs, ... }: {
  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "teams"
    ];
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    awscli
    bun
    chezmoi
    crane
    direnv
    fd
    ffmpeg
    fzf
    git
    gnugrep
    gnupg
    go
    hledger
    ipcalc
    jq
    k9s
    keepassxc
    kubectl
    nodejs_20
    nodePackages.pnpm
    pandoc
    php82Packages.composer
    ripgrep
    semgrep
    shellcheck
    skopeo
    teams
    tmuxp
    vim
    yt-dlp
    zoxide
    zsh
  ];
}
