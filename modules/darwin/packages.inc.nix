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
      # "homebrew/core"
      # "homebrew/cask"
      "lstellway/formulae"
    ];

    brews = [
      "acert"
      "docker-compose"
      "mas"
      "mysql-client"
      "watchman"
    ];

    # Note:
    # There is an issue with GUI applications not being available in spotlight search.
    # Installing applications via Homebrew seems to give the better experience for now.
    # @see https://github.com/NixOS/nix/issues/7055
    casks = [
      # "anytype"
      "discord"
      "docker"
      "element"
      "focusrite-control"
      "google-chrome"
      "keepassxc"
      "macfuse"
      # "microsoft-teams"
      "notion"
      # "openoffice"
      "plexamp"
      "qlmarkdown"
      # "readwise-ibooks"
      "slack"
      # "tabula"
      "tailscale"
      "transmit"
      "visual-studio-code"
      "vlc"
    ];

    masApps = {
      "Magnet" = 441258766;
      "Numbers" = 409203825;
      "Pages" = 409201541;
      "Keynote" = 409183694;
      "Pixelmator Pro" = 1289583905;
      # "Logic Pro" = 634148309;
    };
  };
}
