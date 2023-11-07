# TODO:
# How to get Spotlight to index /run/current-system/Applications
# @see https://github.com/NixOS/nix/issues/7055
{ inputs, system, users, ... }:
let
  configuration = { pkgs, ... }: {
    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;

    # Necessary for using flakes on this system.
    nix.settings.experimental-features = "nix-command flakes";

    # Create /etc/zshrc that loads the nix-darwin environment.
    programs.zsh.enable = true;  # default shell on catalina
    # programs.fish.enable = true;

    # Set Git commit hash for darwin-version.
    system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 4;

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = system;
  };

  home-manager-config = import ./home-manager.nix {
    inherit users;
  };
in
inputs.darwin.lib.darwinSystem {
  modules = [
    configuration
    # Global packages
    ./packages.nix
    # Home manager with nix-darwin in flakes
    # @see https://nix-community.github.io/home-manager/index.html#sec-flakes-nix-darwin-module
    inputs.home-manager.darwinModules.home-manager
    home-manager-config
  ];
}

