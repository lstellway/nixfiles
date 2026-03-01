## 1. Module Scaffold

- [x] 1.1 Create `modules/home-manager/neovim/` directory with an `init/` subdirectory
- [x] 1.2 Create `neovim.inc.nix` with `programs.neovim` enabled and `defaultEditor = true`

## 2. Base Settings

- [x] 2.1 Create `init/options.lua` migrating all settings from `custom.vim`: clipboard (`unnamedplus`), relative line numbers, no backup/swap files, split directions (right/below), and 2-space indentation for JS/TS/PHP filetypes
- [x] 2.2 Create `init/keymaps.lua` migrating all key mappings from `custom.vim` (buffer delete `<C-X>`, window navigation, etc.) using `vim.keymap.set`
- [x] 2.3 Confirm the vimwiki `BufNewFile,BufRead *.md set filetype=vimwiki` autocmd is not carried over — `.md` files should use `filetype=markdown`
- [x] 2.4 Remove `xdg.configFile."vim/coc-settings.json"` from the home-manager configuration

## 3. LSP Stack

- [x] 3.1 Add `nvim-lspconfig`, `nvim-cmp`, `cmp-nvim-lsp`, `cmp-buffer`, `cmp-path`, and `cmp_luasnip` (or minimal snippet engine) to `programs.neovim.plugins`
- [x] 3.2 Add language server binaries to `programs.neovim.extraPackages`: `gopls`, `typescript-language-server`, `nil` (or `nixd`), `pyright`, `rust-analyzer`, `yaml-language-server`, `vscode-langservers-extracted`; document `solargraph` as a known gap
- [x] 3.3 Create `init/lsp.lua` with an `on_attach` function and `nvim-lspconfig` setup calls for each language server
- [x] 3.4 Implement LSP key mappings in `on_attach`: `gd`, `gy`, `gi`, `gr`, `K`, `<leader>rn`, `<leader>f`, `<leader>ac`, `[g` / `]g`
- [x] 3.5 Configure `nvim-cmp` with LSP, buffer, and path sources; set `<CR>` to confirm, `<C-J>`/`<C-K>` to navigate; preserve `noselect` default
- [x] 3.6 Implement format-on-save via `BufWritePre` autocommand using `vim.lsp.buf.format` for: JSON, JS, TS, JSX, TSX, Nix, Python, Rust

## 4. Plugins

- [x] 4.1 Add plugin entries to `neovim.inc.nix`: `telescope.nvim`, `plenary.nvim`, `lualine.nvim`, `Comment.nvim`, `Navigator.nvim`, `vim-ledger`
- [x] 4.2 Create `init/plugins.lua` and configure Telescope: `<C-p>` → `find_files`, `<leader>rg` → `live_grep`
- [x] 4.3 Configure `lualine.nvim` with statusline (mode, filename, filetype, line/col, git branch) and tabline (open buffers), replicating the `airline.vim` tabline behavior
- [x] 4.4 Configure `Comment.nvim` (setup call enabling `gc` operator and `gcc` line toggle)
- [x] 4.5 Configure `Navigator.nvim` with `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` bindings

## 5. Cleanup

- [x] 5.1 Remove all CoC plugins from the plugin list: `coc-nvim` and all `coc-*` extension packages
- [x] 5.2 Remove Vimscript plugins no longer carried over: `vim-sensible`, `vim-airline`, `vim-airline-themes`, `fzf-vim`, `vim-commentary`, `vim-tmux-navigator`, `vim-matchup`, `vim-fugitive`, `vimwiki`
- [x] 5.3 Rename or disable `modules/home-manager/vim/vim.inc.nix` (e.g., `.bak`) to prevent it from being auto-imported during testing

## 6. Verification

- [x] 6.1 Apply home-manager and confirm Neovim starts without errors
- [x] 6.2 Open a TypeScript or Go file and verify the language server attaches, diagnostics appear, and completions work
- [x] 6.3 Test `<C-p>` (file finder) and `<leader>rg` (live grep) via Telescope
- [x] 6.4 Verify the statusline and buffer tabline render correctly
- [x] 6.5 Verify `gcc` toggles a comment and `<C-h/j/k/l>` navigates between Neovim splits and tmux panes
- [x] 6.6 Open a `.md` file and confirm `:set filetype?` returns `markdown`
- [ ] ~~6.7 Delete the old `modules/home-manager/vim/` directory once all checks pass~~
