{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager?ref=release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  # TODO:
  # This could be a great way to import modules specific to different OS
  # @see https://github.com/reckenrode/nixos-configs/blob/3f80edaaadec7608761639648762e6d88f966dac/flake.nix#L33-L35
  outputs = inputs@{ self, darwin, home-manager, nixpkgs }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations.bananas = import ./modules/darwin.nix {
      inherit inputs;
      system = "aarch64-darwin";
      users = {
        logan = { directory = "/Users/logan"; };
      };
    };
  };
}
