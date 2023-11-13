inputs:
let
  modules = import ../modules.nix inputs;
in
inputs.darwin.lib.darwinSystem {
  modules = modules.common ++ modules.darwin ++ [
    (import ./system.nix inputs)
    # Home manager with nix-darwin in flakes
    # @see https://nix-community.github.io/home-manager/index.html#sec-flakes-nix-darwin-module
    inputs.home-manager.darwinModules.home-manager
    (import ../home-manager inputs)
  ];
}

