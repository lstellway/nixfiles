{ pkgs, ... }: {
  # Fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-sans
      source-code-pro
    ];
  };
}

