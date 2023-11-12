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
    plugins = with pkgs; [
      vimPlugins.vim-sensible
      vimPlugins.vim-matchup
      vimPlugins.vim-tmux-navigator
      vimPlugins.fzf-vim
      vimPlugins.vim-ledger
      vimPlugins.vim-fugitive
      vimPlugins.vim-commentary
      vimPlugins.vim-airline
      vimPlugins.vim-airline-themes
      vimPlugins.vimwiki
      # Conquer of completion
      vimPlugins.coc-nvim
      vimPlugins.coc-tsserver
      vimPlugins.coc-html
      vimPlugins.coc-prettier
      vimPlugins.coc-css
      vimPlugins.coc-docker
      vimPlugins.coc-go
      vimPlugins.coc-emmet
      vimPlugins.coc-eslint
      vimPlugins.coc-yaml
      vimPlugins.coc-toml
      vimPlugins.coc-json
      vimPlugins.coc-solargraph
      vimPlugins.coc-tailwindcss
    ];
  };
}

