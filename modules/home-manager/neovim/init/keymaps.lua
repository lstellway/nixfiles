local map = vim.keymap.set

-- Delete buffer without closing the split
map("n", "<C-X>", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- Tab navigation
map("n", "<Tab>", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<S-Tab>", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

-- LSP bindings are set up in lsp.lua via on_attach
-- Telescope bindings are set up in plugins.lua
