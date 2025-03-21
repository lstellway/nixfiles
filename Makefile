.PHONY:

# Install Nix
deps:
	@command -v nix-env > /dev/null 2>&1 \
		|| curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
# Use Determinate Systems installer
# @see https://github.com/DeterminateSystems/nix-installer
# curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
# Default installer
# @see https://nix.dev/install-nix.html
# curl -L https://nixos.org/nix/install | sh

NIX_DARWIN_MULTI_USER="/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
NIX_DARWIN_SINGLE_USER="$(HOME)/.nix-profile/etc/profile.d/nix.sh"

# Initialize the Darwin flake
# Only need to run the first time after installing Nix.
darwin-init:
	# Install Flake with nix-darwin
	@# @see https://github.com/LnL7/nix-darwin
	@nix run --extra-experimental-features "nix-command flakes" nix-darwin -- switch --flake .

# Rebuild
darwin:
	# Rebuild Darwin configuration
	@darwin-rebuild switch --flake .

# Backup files
# The rebuild often complains about these files existing.
darwin-backup:
	sudo mv /etc/bashrc /etc/bashrc.before-nix-darwin
	sudo mv /etc/zshrc /etc/zshrc.before-nix-darwin
	sudo mv /etc/zprofile /etc/zprofile.before-nix-darwin

# Update the flake lock when changing dependencies.
# Eg. when upgrading nixpkgs
darwin-update:
	@nix flake update --extra-experimental-features nix-command --extra-experimental-features flakes

home-manager-help:
	man home-configuration.nix

