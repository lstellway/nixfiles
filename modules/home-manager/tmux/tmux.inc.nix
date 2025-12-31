{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      yank
    ];
    extraConfig = pkgs.lib.readFile ./tmux.conf;
  };
}
