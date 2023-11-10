{ lib, pkgs, ... }: {
  # Example
  # @see https://github.com/gilacost/dot-files/blob/3eddc6013abfd95852d3825837d67e86406328d4/darwin-configuration.nix#L255
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
