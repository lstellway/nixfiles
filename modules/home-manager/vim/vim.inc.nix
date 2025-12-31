{ pkgs, ... }:
let
  inherit (pkgs) lib stdenv;
in
{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = pkgs.lib.concatStrings (
      map (script: (pkgs.lib.readFile script) + "\n") [
        ./init/airline.vim
        ./init/coc.vim
        ./init/custom.vim
        ./init/fzf.vim
        ./init/ledger.vim
        ./init/theme.vim
        ./init/vimwiki.vim
      ]
    );
    # Fix system clipboard for Darwin
    # @see https://hardselius.github.io/vim-nix-darwin/
    # @see https://stackoverflow.com/a/76594191
    packageConfigurable = lib.mkIf stdenv.isDarwin pkgs.vim-darwin;
    plugins = with pkgs.vimPlugins; [
      coc-css
      coc-docker
      coc-emmet
      coc-eslint
      coc-go
      coc-html
      coc-json
      coc-nvim
      coc-prettier
      coc-solargraph
      coc-tailwindcss
      coc-toml
      coc-tsserver
      coc-yaml
      fzf-vim
      vim-airline
      vim-airline-themes
      vim-commentary
      vim-fugitive
      vim-ledger
      vim-matchup
      vim-sensible
      vim-tmux-navigator
      vimwiki
    ];
  };

  xdg.configFile."vim/coc-settings.json" = {
    enable = true;
    text = builtins.toJSON {
      "coc.preferences.formatOnSaveFiletypes" = [
        "json"
        "javascript"
        "javascriptreact"
        "typescript"
        "typescriptreact"
        "nix"
        "python"
        "rust"
      ];

      "suggest.noselect" = true;
      "suggest.enablePreview" = true;
    };
  };
}

