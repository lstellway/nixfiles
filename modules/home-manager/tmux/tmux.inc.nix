# Tmux configuration
# Additional settings in tmux.conf (prefix key, vi mode, pane behavior)
{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible            # Sensible default settings
      vim-tmux-navigator  # Seamless Ctrl+hjkl between tmux panes and vim splits
      yank                # Copy to system clipboard from tmux
    ];
    extraConfig = pkgs.lib.readFile ./tmux.conf;
  };
}
