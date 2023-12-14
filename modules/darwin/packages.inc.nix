{ lib, pkgs, ... }: {
  # Homebrew configuration
  # @see https://daiderd.com/nix-darwin/manual/index.html#opt-homebrew.enable
  homebrew = {
    enable = true;

    onActivation = {
      upgrade = true;
      autoUpdate = true;
      cleanup = "zap";
    };

    global = {
      autoUpdate = true;
      brewfile = true;
      lockfiles = true;
    };

    taps = [
      "homebrew/core"
      "homebrew/cask"
    ];

    brews = [
      "docker-compose"
      "mysql-client"
    ];

    # Note:
    # There is an issue with GUI applications not being available in spotlight search.
    # Installing applications via Homebrew seems to give the better experience for now.
    # @see https://github.com/NixOS/nix/issues/7055
    casks = [
      "docker"
      "keepassxc"
      "microsoft-teams"
      # "openoffice"
      "visual-studio-code"
      "vlc"
    ];
  };
}
