{ lib, pkgs, ... }: {
  # Allow installation of proprietary applications
  # nixpkgs.config = {
  #   allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #     "teams"
  #   ];
  # };

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
    git
    gnugrep
    gnupg
    go
    hledger
    hledger-ui
    hledger-web
    ipcalc
    jq
    k9s
    kubectl
    nodejs_20
    nodePackages.pnpm
    pandoc
    php82Packages.composer
    ripgrep
    ripgrep-all
    semgrep
    shellcheck
    skopeo
    tmuxp
    vim
    yt-dlp
    zoxide
    zsh
  ];
}
