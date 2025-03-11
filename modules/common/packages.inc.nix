{ lib, pkgs, ... }: {
  # Allow installation of proprietary applications
  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "packer"
      "terraform"
      # "teams"
    ];
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # @see https://aider.chat
    aider-chat
    # @see https://atlasgo.io
    atlas
    awscli
    # @see https://bazel.build
    bazel
    # @see https://buf.build
    buf
    # @see https://bun.sh
    bun
    chezmoi
    # @see https://cilium.io
    cilium-cli
    # Google's CLI tool for managing container images
    # @see https://github.com/google/go-containerregistry/blob/55ffb0092afd1313edad861a553b4fcea21b4da2/cmd/crane/doc/crane.md
    crane
    # Tool to help automate shell environments based on the working directory
    # @see https://direnv.net
    direnv
    # DigitalOcean CLI
    # @see https://github.com/digitalocean/doctl
    doctl
    envsubst
    # `find` alternative
    # @see https://github.com/sharkdp/fd
    fd
    ffmpeg
    # Cloudflare Go CLI
    flarectl
    # File change monitor
    # @see https://github.com/emcrisostomo/fswatch
    fswatch
    # GNU flavor of the `grep` CLI tool
    # @see https://www.gnu.org/software/grep/
    gnugrep
    # OpenGPG toolset for signing and encrypting
    # @see https://www.gnupg.org
    gnupg
    go
    # gRPC client from FullStory
    # @see https://github.com/fullstorydev/grpcurl
    grpcurl
    grpcui
    # Font conversion utility
    # @see https://github.com/kseo/sfnt2woff
    haskellPackages.sfnt2woff
    hledger
    hledger-ui
    hledger-web
    id3lib
    # IP subnet calculator
    # @see https://github.com/kjokjo/ipcalc
    ipcalc
    # Jira CLI
    # @see https://github.com/ankitpokhrel/jira-cli
    # jira-cli-go
    # Command-line JSON parser
    # @see https://jqlang.github.io/jq/
    jq
    # @see https://nixpacks.com
    nixpacks
    nodejs_20
    nodePackages.pnpm
    # OpenTofu - open-source Terraform fork
    # @see https://opentofu.org/
    opentofu
    # @see https://www.packer.io/
    packer
    # Document conversion utility
    # @see https://pandoc.org
    pandoc
    # PHP package manager
    # @see https://getcomposer.org
    php82Packages.composer
    # @see https://protobuf.dev
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
    # see https://rclone.org
    rclone
    # CLI app using Mozilla's Readability library
    # @see https://gitlab.com/gardenappl/readability-cli
    # readability-cli
    # Recursive file search
    # @see https://github.com/BurntSushi/ripgrep
    ripgrep
    # Extension of Ripgrep with the ability to search binary file formats (PDF, etc..)
    # @see https://github.com/phiresky/ripgrep-all
    ripgrep-all
    rustc cargo
    # Code static analysis
    # @see https://semgrep.dev
    semgrep
    # Shell script debugging
    # @see https://www.shellcheck.net
    shellcheck
    # Utility to manage remote container repositories
    # @see https://github.com/containers/skopeo
    skopeo
    # Gitea CLI client
    tea
    terraform
    # terraformer
    # cf-terraforming
    vim
    xsv
    yt-dlp
    zoxide
    zsh
  ];
}
