{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
        };
      }
    ];
    initExtra = pkgs.lib.concatStrings (
      # Read contents of provided file paths
      map (script: (pkgs.lib.readFile script) + "\n") [
        ./scripts/aliases.sh
        ./scripts/aws.sh
        ./scripts/docker.sh
        ./scripts/git.sh
        ./scripts/homebrew.sh
        ./scripts/prompt.zsh
        ./scripts/timer.sh
      ]
    );
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}

