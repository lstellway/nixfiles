## Context

The current editor setup lives in `modules/home-manager/vim/vim.inc.nix` and uses `programs.vim` with a collection of vimscript init files and a heavy plugin set centered on `coc-nvim` for LSP support. CoC requires Node.js at runtime and maintains its own extension ecosystem separate from Nix, which creates an out-of-band dependency that is difficult to manage declaratively.

Neovim ships with a native LSP client, a Lua runtime, and a rich plugin ecosystem that integrates cleanly with Nix and home-manager. The migration replaces the entire Vim module with a `programs.neovim`-based equivalent, reorganized around three logical capabilities: base settings, LSP stack, and plugins.

Module auto-discovery in `modules/modules.nix` picks up all `*.inc.nix` files under `modules/home-manager/` automatically, so the swap from `vim.inc.nix` to `neovim.inc.nix` requires no changes to any import lists.

## Goals / Non-Goals

**Goals:**

- Replace `programs.vim` with `programs.neovim`, retaining all editor behavior the user depends on
- Eliminate the Node.js runtime dependency for LSP by switching to native Neovim LSP
- Migrate all configuration to Lua
- Replace `vim-airline` → `lualine.nvim`, `fzf-vim` → `telescope.nvim`
  **Non-Goals:**
- Adding new language server support beyond what CoC previously covered
- Migrating shell-level fzf integration (`programs.fzf` stays as-is)
- Wiring up the Catppuccin theme (infrastructure exists but is out of scope for this change)
- Any changes to non-editor home-manager modules

## Decisions

### File layout: single neovim.inc.nix with inline Lua vs. external Lua files

**Decision**: Use `programs.neovim.extraLuaConfig` for short/simple settings and `xdg.configFile` entries for larger Lua modules (LSP setup, plugin configs). A single `neovim.inc.nix` is the entry point.

**Rationale**: Keeping everything in one `.inc.nix` file with `pkgs.lib.readFile` for Lua files mirrors the existing pattern (which concatenates `.vim` files). This keeps the Nix module clean and allows Lua files to be edited without Nix syntax awareness. The directory structure becomes `modules/home-manager/neovim/neovim.inc.nix` with `init/` subdirectory for Lua files.

**Alternative considered**: Pure `extraLuaConfig` with heredocs — harder to read and no syntax highlighting in the editor for the Lua portions.

---

### LSP: nvim-lspconfig + nvim-cmp vs. an all-in-one distribution (e.g., LazyVim, AstroNvim)

**Decision**: Use `nvim-lspconfig` directly with `nvim-cmp`, configured by hand.

**Rationale**: Distributions abstract away the Nix integration and typically expect to manage plugins themselves (often via `lazy.nvim`), which conflicts with home-manager's declarative plugin list. Hand-configuring `nvim-lspconfig` is well-documented and keeps the setup transparent and auditable.

**Alternative considered**: `lsp-zero.nvim` as a thin opinionated wrapper — reduces boilerplate but adds a dependency for little gain given the Nix context.

---

### Language server delivery: extraPackages vs. system packages

**Decision**: Provide language server binaries via `programs.neovim.extraPackages` in `neovim.inc.nix`.

**Rationale**: Co-locating server packages with the editor config makes the full setup self-contained within the neovim module. Servers available in nixpkgs (gopls, typescript-language-server, nil, pyright, rust-analyzer, yaml-language-server, vscode-langservers-extracted for json/css/html) cover all CoC languages. `solargraph` (Ruby) may require a gem install and should be noted as a known gap.

**Alternative considered**: Installing servers at the system/profile level — scatters the dependency and makes the editor module incomplete on its own.

---

### Vimscript plugin replacements

**Decision**: Replace all Vimscript plugins with Lua-native equivalents where one exists. Remove plugins with no clear replacement rather than carrying over Vimscript debt.

| Removed                              | Replacement      | Notes                                      |
| ------------------------------------ | ---------------- | ------------------------------------------ |
| `vim-commentary`                     | `Comment.nvim`   | Direct drop-in                             |
| `vim-tmux-navigator`                 | `Navigator.nvim` | Same keybind contract                      |
| `vim-matchup`                        | —                | Dropped; treesitter handles basic matching |
| `vim-fugitive`                       | —                | Dropped; not actively used                 |
| `vim-airline` + `vim-airline-themes` | `lualine.nvim`   |                                            |
| `fzf-vim`                            | `telescope.nvim` |                                            |
| `vim-sensible`                       | —                | Redundant in Neovim                        |
| `vimwiki`                            | —                | Follow-up change                           |

**Exception**: `vim-ledger` is retained — no Lua alternative exists and it is low-complexity (filetype detection + syntax only).

---

### Config delivery method for Lua init files

**Decision**: Use `pkgs.lib.readFile` to inline Lua files into `extraLuaConfig`, mirroring the existing vimscript approach.

**Rationale**: Keeps the same file-per-concern structure (`init/options.lua`, `init/keymaps.lua`, `init/lsp.lua`, `init/plugins.lua`) that the current `init/*.vim` layout uses. Files are readable as plain Lua and version-controlled alongside the Nix module.

## Risks / Trade-offs

- **solargraph not in nixpkgs as a standalone binary** → The Ruby LSP server is a gem and requires a working Ruby environment. Mitigation: document this as a known gap; skip `solargraph` in `extraPackages` and note it must be installed separately if Ruby LSP is needed.

- **nvim-cmp API churn** → `nvim-cmp` has had breaking changes historically. Mitigation: pin to the nixpkgs version; avoid using deprecated APIs in initial config.

- **Telescope requires ripgrep for live_grep** → `rg` must be in PATH. Mitigation: `ripgrep` is already present in `modules/darwin/packages.inc.nix`; verify it is also present in any NixOS profiles.

## Migration Plan

1. Create `modules/home-manager/neovim/` directory with `neovim.inc.nix` and `init/` subdirectory
2. Implement `neovim-base`: `programs.neovim` block, `init/options.lua`, `init/keymaps.lua`
3. Implement `neovim-lsp`: `init/lsp.lua` with lspconfig + cmp setup, add language server packages to `extraPackages`
4. Implement `neovim-plugins`: plugin list in `neovim.inc.nix`, `init/plugins.lua` for telescope/lualine/Comment.nvim/Navigator.nvim config
5. Remove `modules/home-manager/vim/vim.inc.nix` (or rename to `.bak` during testing)
6. Apply home-manager and verify Neovim starts without errors
7. Delete old `modules/home-manager/vim/` directory once verified

**Rollback**: The old `vim.inc.nix` and its `init/*.vim` files are preserved in git history. Reverting is a single `git revert` or restore of the file.

## Open Questions

- Should `solargraph` be wired up at all, or removed from the language server list until a clean Nix-managed Ruby setup exists?
- Is `nil` or `nixd` preferred for the Nix language server? (`nixd` has better expression evaluation but `nil` is lighter and more stable.)
- Should `init/lsp.lua` configure all servers uniformly with default settings, or are there per-language overrides to carry over from the old CoC config?
- **Wiki tooling (follow-up)**: `vimwiki` is not being carried over. A dedicated follow-up change should evaluate `wiki.vim` vs `obsidian.nvim` for a markdown-native workflow. Key question: functional gaps between the two — `wiki.vim` is lightweight and editor-first; `obsidian.nvim` requires an Obsidian vault but gains backlinks, graph view, and sync across devices. Neither uses a custom file format.
