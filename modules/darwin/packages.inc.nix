# GUI applications are installed via Homebrew so they appear in /Applications
# and are available via Spotlight search. Nix-installed .app bundles don't
# integrate well with Spotlight on macOS.
# @see https://github.com/NixOS/nix/issues/7055
#
# CLI tools go in common/packages.inc.nix via Nix instead.
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
      "dcmfx/tap"
      "lstellway/formulae"
    ];

    brews = [
      "acert"
      "dcmfx"
      "mas"
      "mysql-client"
      "ollama"
      # "watchman"
    ];

    # Note:
    # There is an issue with GUI applications not being available in spotlight search.
    # Installing applications via Homebrew seems to give the better experience for now.
    # @see https://github.com/NixOS/nix/issues/7055
    casks = [
      # "anytype"
      "asana"
      "claude"
      "claude-code"
      "cursor"
      "discord"
      # "docker"
      "element"
      "figma"
      "firefox"
      "focusrite-control"
      "ghostty"
      "google-chrome"
      "graphiql"
      "ireal-pro"
      "keepassxc"
      "lm-studio"
      "macfuse"
      "mongodb-compass"
      # "microsoft-teams"
      "notion"
      "obs"
      # "openoffice"
      "plexamp"
      "qlmarkdown"
      # "readwise-ibooks"
      "rancher"
      "rectangle"
      "slack"
      # "tabula"
      "tailscale-app"
      "transmit"
      "vscodium"
      "vlc"
      "zen"
    ];

    masApps = {
      # "Magnet" = 441258766;
      "Numbers" = 409203825;
      "Pages" = 409201541;
      "Keynote" = 409183694;
      "Pixelmator Pro" = 1289583905;
      # "Logic Pro" = 634148309;
    };
  };
}
