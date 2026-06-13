# Neovim configuration — see README.md in this directory for details.
# Plugins are installed via Nix; configuration is written in Lua.
{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    # Lua config files are concatenated in order: general options first,
    # then keymaps, LSP, plugins, and filetype-specific config last.
    initLua = pkgs.lib.concatStrings (
      map (script: (pkgs.lib.readFile script) + "\n") [
        ./init/options.lua
        ./init/keymaps.lua
        ./init/lsp.lua
        ./init/plugins.lua
        ./init/markdown.lua
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

      # Markdown
      render-markdown-nvim
      (nvim-treesitter.withPlugins (p: [
        p.markdown
        p.markdown_inline
      ]))
    ];
    extraPackages = with pkgs; [
      gopls
      typescript-language-server
      nil
      pyright
      rust-analyzer
      yaml-language-server
      vscode-langservers-extracted
      typescript
    ];
  };
}
