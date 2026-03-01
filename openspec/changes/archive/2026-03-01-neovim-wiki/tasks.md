## 1. Nix Plugin Configuration

- [x] 1.1 Add `render-markdown-nvim` to `programs.neovim.plugins` in `neovim.inc.nix`
- [x] 1.2 Replace any bare `nvim-treesitter` entry with `nvim-treesitter.withPlugins` pattern, including `markdown` and `markdown_inline` parsers

## 2. Treesitter Setup

- [x] 2.1 Add `nvim-treesitter` setup call in `plugins.lua` (or a new `markdown.lua` init file) with highlight and indent modules enabled
- [x] 2.2 Verify Treesitter highlighting is active for `.md` files after rebuild

## 3. render-markdown.nvim Setup

- [x] 3.1 Add `render-markdown.nvim` setup call scoped to `filetypes = { "markdown" }`
- [x] 3.2 Verify headers, bold/italic, list bullets, checkboxes, and code blocks render correctly in a test `.md` file

## 4. Markdown FileType Autocommand

- [x] 4.1 Add `autocmd FileType markdown` block that sets `foldmethod=expr`, `foldexpr=nvim_treesitter#foldexpr()`, and `foldlevel=99`
- [x] 4.2 Add `<C-Space>` checkbox toggle keymap (`buffer = true`) inside the same autocommand
- [ ] 4.3 Verify folding works — open a multi-section `.md` file and fold/unfold with `za`
- [ ] 4.4 Verify `<C-Space>` toggles `- [ ]` ↔ `- [x]` and does not fire outside Markdown buffers
