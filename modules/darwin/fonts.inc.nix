{ pkgs, ... }: {
  # Fonts
  fonts = {
    packages = with pkgs; [
      inter
      noto-fonts-cjk-sans
      source-code-pro
    ];
  };
}

