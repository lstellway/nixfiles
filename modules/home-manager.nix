{ users, ... }: {
  # Default editor
  environment.variables.EDITOR = "vim";

  # Declare OS users
  users.users = builtins.mapAttrs (name: user: {pkgs, ...}: {
    shell = pkgs.zsh;
    name = name;
    home = user.directory;
  }) users;

  # Configure home manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users = builtins.mapAttrs (name: user: {pkgs, ...}: {
    home.username = name;
    home.homeDirectory = user.directory;

    # User-specific packages
    # home.packages = [ pkgs.atool pkgs.httpie ];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "23.05";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  }) users;
}

