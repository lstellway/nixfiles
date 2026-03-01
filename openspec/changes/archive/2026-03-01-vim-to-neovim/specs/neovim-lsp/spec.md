## ADDED Requirements

### Requirement: Native LSP configured via nvim-lspconfig
The Neovim configuration SHALL include `nvim-lspconfig` and configure language servers for all languages previously covered by CoC: Go (`gopls`), TypeScript/JavaScript (`ts_ls` or `eslint`), JSON (`jsonls`), YAML (`yamlls`), CSS (`cssls`), HTML (`html`), Nix (`nil` or `nixd`), Python (`pyright` or `pylsp`), Rust (`rust-analyzer`), and Ruby (`solargraph`). Language server binaries SHALL be provided via `programs.neovim.extraPackages` or the system Nix configuration rather than Node.js extensions.

#### Scenario: LSP attaches to a TypeScript file
- **WHEN** a `.ts` or `.tsx` file is opened
- **THEN** the TypeScript language server SHALL attach and diagnostics SHALL be available

#### Scenario: LSP attaches to a Go file
- **WHEN** a `.go` file is opened
- **THEN** `gopls` SHALL attach and provide completions, diagnostics, and go-to-definition

#### Scenario: No Node.js dependency
- **WHEN** the configuration is applied on a system without Node.js in PATH
- **THEN** LSP functionality SHALL still be available for all configured languages

### Requirement: Completion via nvim-cmp
The configuration SHALL include `nvim-cmp` as the completion engine, with sources configured for LSP (`cmp-nvim-lsp`), buffer words (`cmp-buffer`), and file paths (`cmp-path`). Completion SHALL be triggered manually or automatically with configurable behavior. The `noselect` default (no item auto-selected) from the old CoC config SHALL be preserved.

#### Scenario: LSP completion appears
- **WHEN** the user types in insert mode in an LSP-attached buffer
- **THEN** a completion menu SHALL appear with LSP-sourced suggestions

#### Scenario: Completion confirm mapping
- **WHEN** the user presses `<CR>` with a completion item highlighted
- **THEN** the item SHALL be inserted and the completion menu SHALL close

#### Scenario: Completion navigation
- **WHEN** the completion menu is open
- **THEN** `<C-J>` and `<C-K>` SHALL navigate down and up through items respectively

### Requirement: LSP key mappings
The key mappings from `coc.vim` SHALL be re-implemented as native LSP mappings using `vim.lsp.buf.*` APIs. Required mappings: `gd` (go to definition), `gy` (go to type definition), `gi` (go to implementation), `gr` (go to references), `K` (hover documentation), `<leader>rn` (rename symbol), `<leader>f` (format), `<leader>ac` (code action), diagnostic navigation (`[g` / `]g`).

#### Scenario: Go to definition
- **WHEN** the user presses `gd` on a symbol in an LSP-attached buffer
- **THEN** the cursor SHALL jump to the symbol's definition

#### Scenario: Hover documentation
- **WHEN** the user presses `K` on a symbol
- **THEN** a floating window SHALL display the symbol's documentation

#### Scenario: Rename symbol
- **WHEN** the user presses `<leader>rn` on a symbol
- **THEN** a prompt SHALL appear to enter a new name, and all references SHALL be renamed

#### Scenario: Diagnostic navigation
- **WHEN** the user presses `[g` or `]g`
- **THEN** the cursor SHALL move to the previous or next diagnostic respectively

### Requirement: Format on save
The configuration SHALL replicate the CoC format-on-save behavior for the filetypes previously configured in `coc-settings.json`: JSON, JavaScript, TypeScript, JSX, TSX, Nix, Python, and Rust. Format on save SHALL be implemented via an LSP `BufWritePre` autocommand using `vim.lsp.buf.format`.

#### Scenario: File formatted on save
- **WHEN** the user saves a TypeScript file with an attached LSP that supports formatting
- **THEN** the buffer SHALL be formatted before writing to disk

#### Scenario: Non-configured filetypes not formatted
- **WHEN** the user saves a file whose filetype is not in the format-on-save list
- **THEN** no automatic formatting SHALL occur
