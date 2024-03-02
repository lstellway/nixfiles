{
  description = "OS configuration flake";

  inputs = {
    # Pin Nix at 23.05
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Import nix-darwin
    # @see https://github.com/LnL7/nix-darwin
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Import home-manager
    # @see https://nix-community.github.io/home-manager/
    home-manager.url = "github:nix-community/home-manager?ref=release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: {
    # Configure Darwin hosts
    darwinConfigurations = {
      # `//` is the "update" operator
      # @see https://nixos.org/manual/nix/stable/language/operators.html#update
      banana = import ./modules/darwin (inputs // {
        system = "aarch64-darwin";
        users = {
          logan = { directory = "/Users/logan"; };
        };
      });
    };
  };
}
