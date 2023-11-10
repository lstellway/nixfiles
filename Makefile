.PHONY:

TMUX_SESSION="lstellway/nixfiles"
tmux:
	@tmux has-session -t $(TMUX_SESSION) \
		&& tmux attach -t $(TMUX_SESSION) \
		|| tmuxp load .tmux.yml

NIX_DARWIN_MULTI_USER="/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
NIX_DARWIN_SINGLE_USER="$(HOME)/.nix-profile/etc/profile.d/nix.sh"

darwin:
	# Install Nix
	@# Uses Determinate Systems installer
	@# @see https://github.com/DeterminateSystems/nix-installer
	@command -v nix-env > /dev/null 2>&1 || \
	    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
	    @# Default installer
	    @# @see https://nix.dev/install-nix.html
	    @# curl -L https://nixos.org/nix/install | sh

	# Source nix to current shell session
	@[ -e "$(NIX_DARWIN_MULTI_USER)" ] && . "$(NIX_DARWIN_MULTI_USER)" \
	    || ([ -e "$(NIX_DARWIN_SINGLE_USER)" ] && . "$(NIX_DARWIN_SINGLE_USER)")

	# Install flake
	@nix run --extra-experimental-features "nix-command flakes" nix-darwin -- switch --flake .


darwin-rebuild:
	darwin-rebuild switch --flake .

