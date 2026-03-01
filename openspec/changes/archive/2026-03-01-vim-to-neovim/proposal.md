## Why

The current vim setup relies on CoC (coc-nvim) for LSP support, which requires Node.js and a separate extension ecosystem that adds complexity and maintenance overhead. Neovim's native LSP client (via `nvim-lspconfig`) and the Lua-based plugin ecosystem provide a more integrated, performant, and maintainable editor configuration with better first-class support from the Nix/home-manager ecosystem.

## What Changes

- Replace `programs.vim` with `programs.neovim` in home-manager configuration
- Remove all coc-nvim plugins and CoC-specific vimscript config (`coc.vim`)
- Replace coc-nvim with native Neovim LSP stack: `nvim-lspconfig`, `nvim-cmp`, and language servers
- Replace `vim-airline` with `lualine.nvim` (or equivalent Neovim-native statusline)
- Replace `fzf-vim` with `telescope.nvim` for fuzzy finding
- Migrate vimscript config files to Lua (`init.lua`)
- Remove the Darwin-specific `packageConfigurable = pkgs.vim-darwin` workaround (not needed for Neovim)
- Remove `xdg.configFile."vim/coc-settings.json"` and replace with LSP-native format-on-save configuration

## Capabilities

### New Capabilities

- `neovim-base`: Core Neovim home-manager module with `programs.neovim` enabled, set as default editor, and base options migrated from `custom.vim` and other vimscript configs into Lua
- `neovim-lsp`: Native LSP configuration replacing coc-nvim — includes `nvim-lspconfig`, `nvim-cmp` (completion), and language server packages for the same languages previously covered by CoC (Go, TypeScript, JSON, YAML, CSS, HTML, etc.)
- `neovim-plugins`: Plugin set migrated to Lua-native alternatives — `telescope.nvim` (replaces fzf-vim), `lualine.nvim` (replaces vim-airline), `Comment.nvim` (replaces vim-commentary), `Navigator.nvim` (replaces vim-tmux-navigator), `vim-ledger` (retained, no Lua alternative exists). Vimscript-only plugins without a clear Lua replacement (`vim-fugitive`, `vim-matchup`, `vimwiki`) are dropped; `%`-matching is covered by Treesitter built-ins; vimwiki alternatives are deferred to a follow-up change.

### Modified Capabilities

## Impact

- `modules/home-manager/vim/vim.inc.nix` — replaced with `modules/home-manager/neovim/neovim.inc.nix` (or renamed in place)
- `modules/home-manager/vim/init/*.vim` — migrated to `init.lua` or Lua module files
- Module auto-discovery via `modules.nix` means no explicit import list needs updating — all `*.inc.nix` files in `modules/home-manager/` are picked up automatically
- Removes Node.js dependency for editor LSP functionality

## Notes

- **vimwiki filetype override**: `custom.vim` sets all `.md` files to `filetype=vimwiki`. This is worth reconsidering — in the new config it could be scoped to a specific wiki path/pattern rather than hijacking all markdown files.
- **fzf overlap**: `modules/home-manager/fzf/fzf.inc.nix` already manages fzf at the shell level. The current `fzf.vim` hardcodes `/opt/homebrew/opt/fzf` (Darwin-specific). Telescope replaces in-editor fuzzy finding entirely; the homebrew path reference should not carry over.
- **`vim-sensible` is redundant**: Neovim ships with sensible defaults built in — this plugin can be dropped without replacement.
- **Catppuccin theme**: `theme.vim` is entirely commented out but the infrastructure existed. Migration is a good opportunity to wire up `catppuccin/nvim` properly.
- **Plugin ecosystem reconsideration**: Many existing plugins have Neovim-native replacements or are no longer needed. Each plugin should be re-evaluated rather than ported wholesale.
