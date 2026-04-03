## Neovim

Neovim configuration managed via Home Manager. Plugins are installed via Nix (not a Neovim plugin manager), and configuration is written in Lua.

### Plugin philosophy

Minimal — only plugins that are actively used. No plugin manager, no lazy-loading framework. Nix handles installation; Lua handles configuration.

| Plugin | Purpose |
|--------|---------|
| nvim-lspconfig | Language Server Protocol client configuration |
| nvim-cmp + cmp-nvim-lsp + cmp-buffer + cmp-path + luasnip | Autocompletion engine with multiple sources |
| telescope-nvim + plenary-nvim | Fuzzy finder for files and grep |
| lualine-nvim | Statusline and buffer tabs |
| comment-nvim | Toggle comments (`gc` in visual mode) |
| Navigator-nvim | Seamless `Ctrl+hjkl` navigation between tmux panes and Neovim splits |
| vim-ledger | Syntax support for hledger/ledger files |
| render-markdown-nvim + nvim-treesitter | In-editor markdown rendering and syntax highlighting |

### Lua configuration files

Configuration is split across multiple Lua files in `init/`, concatenated in order from general to specific:

| Order | File | Responsibility |
|-------|------|----------------|
| 1 | `options.lua` | Core vim options (line numbers, clipboard, indentation, splits) |
| 2 | `keymaps.lua` | General keybindings (buffer/tab navigation) |
| 3 | `lsp.lua` | Completion engine, format-on-save, LSP keybindings, language server activation |
| 4 | `plugins.lua` | Telescope, lualine, Comment.nvim, and Navigator setup |
| 5 | `markdown.lua` | Treesitter, render-markdown, and markdown-specific settings |

Ordering matters because later files may depend on earlier setup (e.g., `plugins.lua` assumes LSP capabilities from `lsp.lua` are already configured).

### Language servers

Language servers are installed as Nix packages (`extraPackages`) and activated in `lsp.lua`:

| Server | Language(s) |
|--------|-------------|
| gopls | Go |
| typescript-language-server | TypeScript / JavaScript |
| nil | Nix |
| pyright | Python |
| rust-analyzer | Rust |
| yaml-language-server | YAML |
| vscode-langservers-extracted | JSON, CSS, HTML, ESLint |

### Adding a new language server

1. Add the server package to `extraPackages` in `neovim.inc.nix`
2. Add the server name to `vim.lsp.enable()` in `init/lsp.lua`
3. Run `make darwin`

### Key bindings

General bindings are in `keymaps.lua`. LSP-specific bindings (go-to-definition, rename, etc.) are in `lsp.lua` and only activate when an LSP server attaches. Telescope bindings (`Ctrl+P` for files, `<leader>rg` for grep) are in `plugins.lua`.
