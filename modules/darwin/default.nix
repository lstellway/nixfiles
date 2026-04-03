# Darwin system entry point.
#
# Assembles the full macOS configuration by combining:
# 1. Common modules (shared packages)
# 2. Darwin-specific modules (Homebrew, fonts, etc.)
# 3. System preferences (system.nix)
# 4. Home Manager (per-user config — shell, git, editor, etc.)
inputs:
let
  modules = import ../modules.nix inputs;
in
inputs.darwin.lib.darwinSystem {
  modules = modules.common ++ modules.darwin ++ [
    (import ./system.nix inputs)
    # Home Manager integration as a nix-darwin module
    # This wires per-user config (home-manager/) into the system build
    # @see https://nix-community.github.io/home-manager/index.html#sec-flakes-nix-darwin-module
    inputs.home-manager.darwinModules.home-manager
    (import ../home-manager inputs)
  ];
}

