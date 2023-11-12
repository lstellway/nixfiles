inputs:
let
  modules = import ./modules inputs;
in
{
  # Environment variables
  environment.variables = {
    PAGER = "less";
  };

  # Declare OS users
  users.users = builtins.mapAttrs (name: user: {pkgs, ...}: {
    name = name;
    home = user.directory;
  }) inputs.users;

  # Configure home manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users = builtins.mapAttrs (name: user: {pkgs, ...}: {
    home.username = name;
    home.homeDirectory = user.directory;

    # Map imported module file paths
    # home.packages = [] ++ (map (pkg: import pkg { inherit pkgs; }) modules.homepkgs);

    launchd.enable = true;

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

    # Import all home-manager modules
    imports = modules.home;
  }) inputs.users;
}

