## Why

The vim-to-neovim migration removed vimwiki without a replacement. Rather than adopting a full wiki system, the goal is a focused set of Markdown editing enhancements that improve the day-to-day experience of working with `.md` files — better in-buffer rendering, folding, and task list support.

## What Changes

- Add `render-markdown.nvim` for inline Markdown rendering (headers, bold, italic, list markers, and code blocks rendered visually in the buffer without leaving Neovim)
- Add `nvim-treesitter` with the Markdown parser, which is required by `render-markdown.nvim` and provides improved syntax highlighting and treesitter-based folding for `.md` files
- Add a `<C-Space>` keymap to toggle Markdown checkboxes (`- [ ]` ↔ `- [x]`) in normal mode
- Enable treesitter-based folding for Markdown files (`foldmethod=expr`)

## Capabilities

### New Capabilities

- `markdown-support`: In-buffer Markdown rendering via `render-markdown.nvim`, Treesitter Markdown integration, checkbox toggle keymap, and folding configuration scoped to `.md` files

### Modified Capabilities

## Impact

- `modules/home-manager/neovim/neovim.inc.nix` — adds `render-markdown-nvim` and `nvim-treesitter` to `programs.neovim.plugins`
- `modules/home-manager/neovim/init/` — new Lua config block for Markdown-specific settings and keymaps
