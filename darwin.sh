#!/usr/bin/env sh

# Install Nix
# Uses Determinate Systems installer
# @see https://github.com/DeterminateSystems/nix-installer
command -v nix-env > /dev/null 2>&1 || \
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    # Default installer
    # @see https://nix.dev/install-nix.html
    # curl -L https://nixos.org/nix/install | sh

# Source nix
# Multi-user installation
local FILE="/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
# Single-user installation
local FILE2="${HOME}/.nix-profile/etc/profile.d/nix.sh"
[ -e "${FILE}" ] && . "${FILE}" \
    || ([ -e "${FILE2}" ] && . "${FILE2}")

# Install via nix
nix run --extra-experimental-features "nix-command flakes" nix-darwin -- switch --flake .

