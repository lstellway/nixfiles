# This file exports an attribute set with modules intended to be included in different contexts.
inputs:

with inputs.nixpkgs.lib; let
  # Referenced from:
  # @see https://github.com/infinisil/system/blob/df9232c4b6cec57874e531c350157c37863b91a0/config/new-modules/default.nix#L7-L16

  # Recursively constructs an attrset of a given folder, recursing on directories, value of attrs is the filetype
  fileAttrsInDirectory = dir: mapAttrs (file: type:
    if type == "directory" then fileAttrsInDirectory "${dir}/${file}" else type
  ) (builtins.readDir dir);

  # Collects all files of a directory as a list of strings of paths
  filesInDirectory = dir: collect isString (
    mapAttrsRecursive (path: type: concatStringsSep "/" path) (fileAttrsInDirectory dir)
  );

  # Filters out directories that don't end with .nix or are this file, also makes the strings absolute
  findFiles = { dir, name ? "", prefix ? "", suffix ? ".nix" }: map (file: dir + "/${file}") (
    filter (file:
      # Ignore default.nix files
      # file != "default.nix"
      # Filter by name
      (name == "" || file == name)
      # Filter by prefix
      && (prefix == "" || hasPrefix prefix (baseNameOf file))
      # Filter by suffix
      && (suffix == "" || hasSuffix suffix file)
    ) (filesInDirectory dir)
  );
in
{
  inherit findFiles;
  common = findFiles { dir = ./common; suffix = ".inc.nix"; };
  darwin = findFiles { dir = ./darwin; suffix = ".inc.nix"; };
  nixos = findFiles { dir = ./nixos; suffix = ".inc.nix"; };
  home = findFiles { dir = ./home-manager; suffix = ".inc.nix"; };
}

