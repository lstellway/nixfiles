{ pkgs, ... }: {
  # System fonts installed via Nix
  fonts = {
    packages = with pkgs; [
      inter                # UI / sans-serif font
      noto-fonts-cjk-sans  # CJK (Chinese, Japanese, Korean) character support
      source-code-pro      # Monospace font for terminal and editor
    ];
  };
}

