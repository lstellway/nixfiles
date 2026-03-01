{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaConfig = pkgs.lib.concatStrings (
      map (script: (pkgs.lib.readFile script) + "\n") [
        ./init/options.lua
        ./init/keymaps.lua
        ./init/lsp.lua
        ./init/plugins.lua
      ]
    );
    plugins = with pkgs.vimPlugins; [
      # LSP
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp_luasnip
      luasnip

      # Fuzzy finder
      telescope-nvim
      plenary-nvim

      # Statusline
      lualine-nvim

      # Comments
      comment-nvim

      # Tmux navigation
      Navigator-nvim

      # Ledger (no Lua alternative)
      vim-ledger
    ];
    extraPackages = with pkgs; [
      gopls
      typescript-language-server
      nil
      pyright
      rust-analyzer
      yaml-language-server
      vscode-langservers-extracted
      nodePackages.typescript
    ];
  };
}
