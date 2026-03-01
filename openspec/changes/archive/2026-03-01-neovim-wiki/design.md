## Context

The neovim configuration currently has no Markdown-specific setup. Treesitter parsers are not installed and there is no in-buffer rendering or quality-of-life tooling for `.md` files. This change adds a focused set of Markdown enhancements using Lua-native plugins that integrate with the existing `programs.neovim` home-manager module.

The existing module structure loads Lua config via `extraLuaConfig` by concatenating files from `modules/home-manager/neovim/init/`. Plugins are declared in `programs.neovim.plugins`.

## Goals / Non-Goals

**Goals:**
- Add `render-markdown.nvim` for in-buffer visual rendering of Markdown syntax
- Add `nvim-treesitter` with `markdown` and `markdown_inline` parsers
- Implement `<C-Space>` checkbox toggle scoped to Markdown buffers
- Enable Treesitter-based folding for Markdown files

**Non-Goals:**
- Browser-based preview (requires external runtime dependency like Deno or Node)
- Wiki-style `[[link]]` navigation
- Table auto-formatting
- Any Obsidian vault integration

## Decisions

### render-markdown.nvim over alternatives
`render-markdown.nvim` is the most actively maintained Lua-native inline rendering plugin. It has no external runtime dependencies — everything is handled in Lua via Treesitter. The alternative `headlines.nvim` is less actively maintained and renders fewer elements (no checkbox glyphs, no code block backgrounds).

### nvim-treesitter as the Treesitter integration layer
`render-markdown.nvim` requires Treesitter parsers. While recent Neovim bundles a Treesitter runtime, it does not ship pre-compiled parsers. `nvim-treesitter` is the standard way to declare and install parsers in a Nix-managed config — parsers can be provided via `pkgs.vimPlugins.nvim-treesitter.withPlugins` to avoid runtime downloads.

Nix pattern:
```nix
(pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
  p.markdown
  p.markdown_inline
]))
```
This pins parsers at build time, consistent with the project's Nix-managed approach.

### Checkbox toggle implemented inline (no plugin)
A checkbox toggle is simple enough to implement as a small Lua function in an `autocmd FileType markdown` block rather than pulling in a dedicated plugin. This keeps the dependency count low.

```lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set("n", "<C-Space>", function()
      local line = vim.api.nvim_get_current_line()
      if line:match("%- %[x%]") then
        vim.api.nvim_set_current_line(line:gsub("%- %[x%]", "- [ ]", 1))
      elseif line:match("%- %[ %]") then
        vim.api.nvim_set_current_line(line:gsub("%- %[ %]", "- [x]", 1))
      end
    end, { buffer = true, desc = "Toggle markdown checkbox" })
  end,
})
```

### Folding via Treesitter expr
Markdown folding will use `foldmethod=expr` with `nvim_treesitter#foldexpr()` set via an `autocmd FileType markdown` block. `foldlevel=99` keeps all folds open on file open. (`foldlevelstart` is global and does not take effect inside a `FileType` autocmd.)

## Risks / Trade-offs

- **nvim-treesitter compile step**: Nix-managed parsers avoid runtime downloads but require `withPlugins` pattern. If other parsers are added later, they must be added to this list. → Mitigation: document the pattern clearly in the Nix file comment.
- **`<C-Space>` in some terminals**: May not be received correctly in terminals without the Kitty keyboard protocol. → Mitigation: acceptable tradeoff; the mapping is scoped to Markdown buffers only so conflicts are limited.
- **render-markdown.nvim conceal mode**: Rendering relies on `conceallevel`. If `conceallevel=0` is set elsewhere in the config, rendering will be suppressed. → Mitigation: `render-markdown.nvim` sets its own `conceallevel` when active; no conflict expected with current config.

## Open Questions

- Should additional Treesitter parsers (e.g., for other languages used in fenced code blocks) be added at this point, or deferred to a separate change?
