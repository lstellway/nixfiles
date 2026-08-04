# Terminal file manager — `y` wrapper cd's the shell to Yazi's last dir on exit
{ ... }: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    # Settings written to ~/.config/yazi/yazi.toml
    # @see https://yazi-rs.github.io/docs/configuration/yazi
    settings.mgr.ratio = [
      1
      1
      3
    ];
    settings.mgr.show_hidden = true;
  };
}
