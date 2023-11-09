{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
    ];
    extraConfig = ''
      # Set prefix key binding
      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix

      # Enable mouse scrolling
      setw -g mouse on

      # Border colors
      set -g pane-border-style fg=cyan
      set -g pane-border-style "bg=gray fg=gray"
      set -g pane-active-border-style "bg=cyan fg=cyan"

      # Open panes and windows in same path
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # Status bar
      set -g status off

      # reload config file (change file location to your the tmux.conf you want to use)
      bind r source-file ~/.tmux.conf
    '';
  };
}

