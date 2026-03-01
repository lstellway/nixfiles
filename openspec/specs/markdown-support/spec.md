# markdown-support Specification

## Purpose
TBD - created by archiving change neovim-wiki. Update Purpose after archive.
## Requirements
### Requirement: Inline Markdown rendering via render-markdown.nvim
The Neovim configuration SHALL include `render-markdown.nvim` and enable it for `markdown` filetype buffers. It SHALL render headers with level-appropriate visual indicators and highlighting, conceal bold/italic markers so text appears styled, replace list bullets with proper bullet characters, render checkboxes as visual glyphs (`☐` / `✓`), apply background highlighting to fenced code blocks, and add a visual indicator to block quotes.

#### Scenario: Headers rendered visually
- **WHEN** a Markdown file is opened
- **THEN** each heading level SHALL be displayed with a distinct visual style and the `#` characters SHALL be concealed

#### Scenario: Bold and italic text rendered
- **WHEN** a Markdown file containing `**bold**` or `_italic_` text is open
- **THEN** the delimiter characters SHALL be concealed and the text SHALL appear styled

#### Scenario: Checkboxes rendered as glyphs
- **WHEN** a Markdown file containing `- [ ]` or `- [x]` list items is open
- **THEN** unchecked items SHALL display as `☐` and checked items SHALL display as `✓`

#### Scenario: Code block highlighted
- **WHEN** a fenced code block is present in the buffer
- **THEN** the block SHALL have a distinct background highlight applied

### Requirement: Treesitter Markdown parser enabled
The Neovim configuration SHALL include `nvim-treesitter` with the `markdown` and `markdown_inline` parsers installed. These parsers SHALL be used for syntax highlighting and folding in Markdown buffers.

#### Scenario: Treesitter highlighting active
- **WHEN** a `.md` file is opened
- **THEN** syntax highlighting SHALL be provided by the Treesitter Markdown parser

#### Scenario: Section folding available
- **WHEN** a `.md` file with multiple headings is open
- **THEN** the user SHALL be able to fold and unfold sections using standard fold keymaps (`za`, `zc`, `zo`)

### Requirement: Checkbox toggle keymap
The Neovim configuration SHALL provide a `<C-Space>` normal-mode keymap scoped to Markdown buffers that toggles the checkbox state of the list item on the current line (`- [ ]` ↔ `- [x]`). The keymap SHALL only be active when `filetype=markdown`.

#### Scenario: Unchecked item toggled
- **WHEN** the cursor is on a line containing `- [ ]` and the user presses `<C-Space>`
- **THEN** the line SHALL be updated to `- [x]`

#### Scenario: Checked item toggled
- **WHEN** the cursor is on a line containing `- [x]` and the user presses `<C-Space>`
- **THEN** the line SHALL be updated to `- [ ]`

#### Scenario: Keymap inactive outside Markdown
- **WHEN** the user presses `<C-Space>` in a non-Markdown buffer
- **THEN** the Markdown checkbox toggle SHALL NOT fire

### Requirement: Treesitter-based folding for Markdown files
Markdown buffers SHALL use `foldmethod=expr` with `foldexpr=nvim_treesitter#foldexpr()` so that sections fold at heading boundaries. `foldlevel` SHALL be set to 99 to keep all folds open by default.

#### Scenario: Folds open on file open
- **WHEN** a Markdown file is opened
- **THEN** all sections SHALL be unfolded by default

#### Scenario: Fold at heading boundary
- **WHEN** the user folds a section under a heading
- **THEN** all content until the next same-level heading SHALL be included in the fold

