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
      "lstellway/formulae"
    ];

    brews = [
      "acert"
    ];

    # Note:
    # There is an issue with GUI applications not being available in spotlight search.
    # Installing applications via Homebrew seems to give the better experience for now.
    # @see https://github.com/NixOS/nix/issues/7055
    casks = [
      # "anytype"
      "discord"
      # "docker"
      "element"
      "focusrite-control"
      "keepassxc"
      "microsoft-teams"
      "notion"
      # "openoffice"
      "plexamp"
      "readwise-ibooks"
      "slack"
      # "tabula"
      "tailscale"
      "visual-studio-code"
      "vlc"
    ];
  };
}
