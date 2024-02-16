.PHONY:

deps:
	# Install Nix
	@command -v nix-env > /dev/null 2>&1 || \
		@# Use Determinate Systems installer
		@# @see https://github.com/DeterminateSystems/nix-installer
		@# curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
		@# Default installer
		@# @see https://nix.dev/install-nix.html
		@curl -L https://nixos.org/nix/install | sh

NIX_DARWIN_MULTI_USER="/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
NIX_DARWIN_SINGLE_USER="$(HOME)/.nix-profile/etc/profile.d/nix.sh"

init-darwin:
	@# Source nix to current shell session
	@[ -e "$(NIX_DARWIN_MULTI_USER)" ] && . "$(NIX_DARWIN_MULTI_USER)" \
	    || ([ -e "$(NIX_DARWIN_SINGLE_USER)" ] && . "$(NIX_DARWIN_SINGLE_USER)")

	# Install Flake with nix-darwin
	@# @see https://github.com/LnL7/nix-darwin
	@nix run --extra-experimental-features "nix-command flakes" nix-darwin -- switch --flake .

darwin-backup:
	sudo mv /etc/bashrc /etc/bashrc.before-nix-darwin
	sudo mv /etc/zshrc /etc/zshrc.before-nix-darwin

darwin:
	# Rebuild Darwin configuration
	@darwin-rebuild switch --flake .

