{ pkgs, ... }: {
  # Fonts
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      noto-fonts-cjk-sans
      source-code-pro
    ];
  };
}

