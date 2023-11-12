{ lib, pkgs, ... }: {
  # nixpkgs.config = {
  #   allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #     "teams"
  #   ];
  # };

  environment.systemPackages = with pkgs; [
    vlc
  ];
}
