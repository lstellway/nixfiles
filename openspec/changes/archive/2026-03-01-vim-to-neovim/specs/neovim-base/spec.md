## ADDED Requirements

### Requirement: Neovim enabled as default editor
The home-manager configuration SHALL enable `programs.neovim` with `defaultEditor = true`, replacing the existing `programs.vim` block. The Darwin-specific `packageConfigurable = pkgs.vim-darwin` SHALL be removed as it is not applicable to Neovim.

#### Scenario: Neovim is the default editor
- **WHEN** the user opens a file from the shell (e.g., `git commit`, `crontab -e`)
- **THEN** Neovim SHALL launch as the editor

### Requirement: Base editor settings in Lua
The Neovim configuration SHALL include a Lua `init.lua` (managed via `programs.neovim.extraLuaConfig` or an `xdg.configFile` entry) that migrates all settings from `custom.vim`. Settings SHALL include: clipboard set to `unnamedplus`, relative line numbers, no backup/swap files (or explicit backup/swap directory configuration), split directions (vertical splits open right, horizontal splits open below), and indentation rules for JavaScript/TypeScript/PHP (2-space tabs).

#### Scenario: Clipboard integration
- **WHEN** the user yanks text in Neovim
- **THEN** the text SHALL be available in the system clipboard

#### Scenario: Relative line numbers
- **WHEN** a buffer is open
- **THEN** the current line SHALL show its absolute number and surrounding lines SHALL show relative offsets

#### Scenario: File-type indentation
- **WHEN** a JavaScript, TypeScript, JSX, TSX, or PHP file is opened
- **THEN** indentation SHALL use 2 spaces (shiftwidth=2, tabstop=2, expandtab)

### Requirement: Key mappings migrated to Lua
All key mappings from `custom.vim` SHALL be re-implemented in Lua using `vim.keymap.set`. This includes buffer deletion (`<C-X>`), window navigation, and any other custom bindings.

#### Scenario: Buffer close mapping
- **WHEN** the user presses `<C-X>` in normal mode
- **THEN** the current buffer SHALL be deleted without closing the window split

### Requirement: Markdown filetype not overridden
The blanket `autocmd BufNewFile,BufRead *.md set filetype=vimwiki` from `custom.vim` SHALL NOT be carried over. All `.md` files SHALL retain `filetype=markdown`. Wiki tooling will be addressed in a follow-up change and SHALL be responsible for its own filetype handling.

#### Scenario: Markdown file opens with correct filetype
- **WHEN** any `.md` file is opened
- **THEN** the filetype SHALL be `markdown`

### Requirement: CoC settings removed
The `xdg.configFile."vim/coc-settings.json"` entry SHALL be removed from the home-manager configuration. Format-on-save behavior SHALL be re-implemented through LSP-native mechanisms (covered by `neovim-lsp` capability).

#### Scenario: No coc-settings.json present
- **WHEN** the home-manager configuration is applied
- **THEN** no `~/.config/vim/coc-settings.json` file SHALL be written
