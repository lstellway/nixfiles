{
  description = "OS configuration flake";

  inputs = {
    # Pin Nix at version
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    # Import nix-darwin
    # @see https://github.com/LnL7/nix-darwin
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Import home-manager
    # @see https://nix-community.github.io/home-manager/
    home-manager.url = "github:nix-community/home-manager?ref=release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: {
    # Configure Darwin hosts
    darwinConfigurations = {
      # `//` is the "update" operator
      # @see https://nixos.org/manual/nix/stable/language/operators.html#update
      banana = import ./modules/darwin (inputs // {
        host = "banana";
        system = "aarch64-darwin";
        users = {
          logan = { directory = "/Users/logan"; };
        };
      });
    };
  };
}
