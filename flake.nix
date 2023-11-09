{
  description = "OS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager?ref=release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: {
    # Rebuild flake:
    # $ darwin-rebuild switch --flake .
    darwinConfigurations = {
      # `//` is the "update" operator
      # @see https://nixos.org/manual/nix/stable/language/operators.html#update
      banana = import ./config/darwin.nix (inputs // {
        system = "aarch64-darwin";
        users = {
          logan = { directory = "/Users/logan"; };
        };
      });
    };
  };
}
