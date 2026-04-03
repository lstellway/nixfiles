-- Telescope
local telescope = require("telescope")
telescope.setup({
  defaults = {
    file_ignore_patterns = { "^%.git/" },
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
    },
  },
  pickers = {
    live_grep = {
      additional_args = { "--hidden" },
    },
    find_files = {
      hidden = true,
    },
  },
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Telescope: find files" })
vim.keymap.set("n", "<leader>rg", builtin.live_grep, { desc = "Telescope: live grep" })

-- lualine
require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = "auto",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { "filename" },
    lualine_x = { "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "Ln %l/%L, Col %c" },
  },
  tabline = {
    lualine_a = {
      {
        "buffers",
        buffers_color = {
          active   = "lualine_a_normal",
          inactive = "lualine_b_normal",
        },
        symbols = { modified = " ●", alternate_file = "", directory = "" },
      },
    },
  },
})

-- Comment.nvim
require("Comment").setup()

-- Navigator.nvim
require("Navigator").setup()

vim.keymap.set({ "n", "t" }, "<C-h>", "<cmd>NavigatorLeft<CR>")
vim.keymap.set({ "n", "t" }, "<C-l>", "<cmd>NavigatorRight<CR>")
vim.keymap.set({ "n", "t" }, "<C-k>", "<cmd>NavigatorUp<CR>")
vim.keymap.set({ "n", "t" }, "<C-j>", "<cmd>NavigatorDown<CR>")
