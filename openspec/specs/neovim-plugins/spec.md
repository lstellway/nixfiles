# neovim-plugins Specification

## Purpose
TBD - created by archiving change vim-to-neovim. Update Purpose after archive.
## Requirements
### Requirement: telescope.nvim replaces fzf-vim
The configuration SHALL include `telescope.nvim` (with `plenary.nvim` as a required dependency) for in-editor fuzzy finding. The `<C-p>` mapping SHALL invoke Telescope's file finder. A `<leader>rg` or equivalent mapping SHALL provide live grep via ripgrep. The Darwin-specific `/opt/homebrew/opt/fzf` path from `fzf.vim` SHALL NOT be carried over. The system-level `programs.fzf` module (shell integration) SHALL remain unaffected.

#### Scenario: File finder opens
- **WHEN** the user presses `<C-p>`
- **THEN** Telescope's `find_files` picker SHALL open

#### Scenario: Live grep available
- **WHEN** the user invokes the grep mapping
- **THEN** Telescope's `live_grep` picker SHALL open using ripgrep

#### Scenario: No Homebrew path reference
- **WHEN** the configuration is applied on a non-Darwin system
- **THEN** no errors SHALL occur due to missing Homebrew paths

### Requirement: lualine.nvim replaces vim-airline
The configuration SHALL include `lualine.nvim` as the statusline plugin, replacing `vim-airline` and `vim-airline-themes`. The statusline SHALL display at minimum: mode, filename, filetype, line/column, and git branch (via a built-in lualine component). The tabline configuration from `airline.vim` SHALL be replicated in lualine's `tabline` section.

#### Scenario: Statusline visible
- **WHEN** a buffer is open
- **THEN** a statusline SHALL be rendered with mode, filename, and position information

#### Scenario: Tabline visible
- **WHEN** multiple buffers are open
- **THEN** a tabline SHALL display open buffers

### Requirement: Comment.nvim replaces vim-commentary
The configuration SHALL include `Comment.nvim` for toggling comments. The `gc` operator and `gcc` line toggle SHALL work as they did with `vim-commentary`. `vim-commentary` SHALL NOT be included.

#### Scenario: Commentary toggling
- **WHEN** the user presses `gc` on a line or visual selection
- **THEN** `Comment.nvim` SHALL toggle comments using the correct comment string for the filetype

### Requirement: Navigator.nvim replaces vim-tmux-navigator
The configuration SHALL include `Navigator.nvim` for seamless Neovim/tmux pane navigation. The `<C-h/j/k/l>` bindings SHALL move focus between Neovim splits and tmux panes. `vim-tmux-navigator` SHALL NOT be included.

#### Scenario: Tmux navigation
- **WHEN** the user presses `<C-h/j/k/l>` in Neovim inside a tmux session
- **THEN** `Navigator.nvim` SHALL move focus to the adjacent tmux pane or Neovim split

### Requirement: vim-ledger retained
`vim-ledger` SHALL be included for ledger/timedot filetype support. No Lua-native alternative exists.

#### Scenario: Ledger filetype
- **WHEN** a `*.timedot` file is opened
- **THEN** the filetype SHALL be set to `ledger` and vim-ledger SHALL activate

### Requirement: Vimscript-only plugins absent
`vim-fugitive`, `vim-commentary`, `vim-tmux-navigator`, `vim-matchup`, and `vimwiki` SHALL NOT be in the plugin list.

#### Scenario: Removed plugins absent
- **WHEN** the configuration is applied
- **THEN** none of `vim-fugitive`, `vim-commentary`, `vim-tmux-navigator`, `vim-matchup`, or `vimwiki` SHALL appear in the plugin list

### Requirement: CoC plugins removed
All `coc-*` plugins (coc-css, coc-docker, coc-emmet, coc-eslint, coc-go, coc-html, coc-json, coc-nvim, coc-prettier, coc-solargraph, coc-tailwindcss, coc-toml, coc-tsserver, coc-yaml) SHALL be removed from `programs.neovim.plugins`. The `coc.vim` init script SHALL be deleted.

#### Scenario: No CoC plugins present
- **WHEN** the home-manager configuration is built
- **THEN** no `coc-*` packages SHALL appear in the Neovim plugin list

### Requirement: vim-sensible removed
The `vim-sensible` plugin SHALL NOT be included in the Neovim plugin list. Neovim's built-in defaults cover all settings provided by vim-sensible.

#### Scenario: vim-sensible absent
- **WHEN** the configuration is applied
- **THEN** `vim-sensible` SHALL NOT be in the plugin list and Neovim SHALL start without errors

