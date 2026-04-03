# Fuzzy finder — integrates with both zsh (Ctrl+R history search) and tmux
{ pkgs, ... }: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
  };
}
