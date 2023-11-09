{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
    ];
    extraConfig = pkgs.lib.readFile ./tmux.conf;
  };
}

