-- Treesitter
require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  indent = { enable = true },
})

-- render-markdown.nvim
require("render-markdown").setup({
  filetypes = { "markdown" },
})

-- Markdown-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Treesitter folding
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt_local.foldlevel = 99

    -- Checkbox toggle
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
