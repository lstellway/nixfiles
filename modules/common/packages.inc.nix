{ lib, pkgs, ... }: {
  # Allow installation of proprietary applications
  # nixpkgs.config = {
  #   allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #     "teams"
  #   ];
  # };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    awscli
    # Google's CLI tool for managing container images
    # @see https://github.com/google/go-containerregistry/blob/55ffb0092afd1313edad861a553b4fcea21b4da2/cmd/crane/doc/crane.md
    crane
    # Tool to help automate shell environments based on the working directory
    # @see https://direnv.net
    direnv
    # `find` alternative
    # @see https://github.com/sharkdp/fd
    fd
    git
    # GNU flavor of the `grep` CLI tool
    # @see https://www.gnu.org/software/grep/
    gnugrep
    # OpenGPG toolset for signing and encrypting
    # @see https://www.gnupg.org
    gnupg
    go
    # IP subnet calculator
    # @see https://github.com/kjokjo/ipcalc
    ipcalc
    # Command-line JSON parser
    # @see https://jqlang.github.io/jq/
    jq
    # CLI GUI to manage Kubernetes cluster resources
    # @see https://k9scli.io
    k9s
    kubectl
    nodejs_20
    nodePackages.pnpm
    # Document conversion utility
    # @see https://pandoc.org
    pandoc
    # PHP package manager
    # @see https://getcomposer.org
    php82Packages.composer
    # Recursive file search
    # @see https://github.com/BurntSushi/ripgrep
    ripgrep
    # Extension of Ripgrep with the ability to search binary file formats (PDF, etc..)
    # @see https://github.com/phiresky/ripgrep-all
    ripgrep-all
    # Code static analysis
    # @see https://semgrep.dev
    semgrep
    # Shell script debugging
    # @see https://www.shellcheck.net
    shellcheck
    # Utility to manage remote container repositories
    # @see https://github.com/containers/skopeo
    skopeo
    # TMUX session manager
    # @see https://github.com/tmux-python/tmuxp
    tmuxp
    vim
    zsh
  ];
}
