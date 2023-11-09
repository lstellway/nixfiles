inputs:
let
  modules = import ./modules inputs;

  configuration = { pkgs, ... }: {
    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;

    # Necessary for using flakes on this system.
    nix.settings.experimental-features = "nix-command flakes";

    # Create /etc/zshrc that loads the nix-darwin environment.
    programs.zsh.enable = true;
    # environment.shells = with pkgs; [ zsh ];

    # Set Git commit hash for darwin-version.
    system.configurationRevision = ({ self, ... }: self.rev or self.dirtyRev or null) inputs;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 4;

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = inputs.system;
  };
in
inputs.darwin.lib.darwinSystem {
  modules = modules.os ++ modules.darwin ++ [
    configuration
    # Home manager with nix-darwin in flakes
    # @see https://nix-community.github.io/home-manager/index.html#sec-flakes-nix-darwin-module
    inputs.home-manager.darwinModules.home-manager
    # Pass along other options (specifically `users`)
    (import ./home-manager.nix inputs)
  ];
}

