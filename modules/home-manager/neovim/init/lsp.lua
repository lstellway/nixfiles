-- Always show sign column so buffer doesn't shift on diagnostics
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"

-- Completion
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- noselect: no item is auto-selected (matches old CoC behavior)
  completion = {
    completeopt = "menu,menuone,noselect",
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-J>"]     = cmp.mapping.select_next_item(),
    ["<C-K>"]     = cmp.mapping.select_prev_item(),
    ["<CR>"]      = cmp.mapping.confirm({ select = false }),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})

-- Format on save
local format_filetypes = {
  json = true,
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
  nix = true,
  python = true,
  rust = true,
}

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    if format_filetypes[vim.bo.filetype] then
      vim.lsp.buf.format({ async = false })
    end
  end,
})

-- LSP key mappings (applied on every LspAttach)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end

    map("n", "gd",         vim.lsp.buf.definition,     "Go to definition")
    map("n", "<leader>i",  function() vim.cmd("vsplit") vim.lsp.buf.definition() end, "Go to definition (split)")
    map("n", "gy",         vim.lsp.buf.type_definition, "Go to type definition")
    map("n", "gi",         vim.lsp.buf.implementation,  "Go to implementation")
    map("n", "gr",         vim.lsp.buf.references,      "Go to references")
    map("n", "K",          vim.lsp.buf.hover,           "Hover documentation")
    map("n", "<leader>rn", vim.lsp.buf.rename,          "Rename symbol")
    map({ "n", "x" }, "<leader>f",  function() vim.lsp.buf.format({ async = true }) end, "Format")
    map({ "n", "x" }, "<leader>ac", vim.lsp.buf.code_action, "Code action")
    map("n", "[g",         vim.diagnostic.goto_prev,    "Previous diagnostic")
    map("n", "]g",         vim.diagnostic.goto_next,    "Next diagnostic")
  end,
})

-- Global LSP config: advertise nvim-cmp capabilities to all servers
vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- Enable language servers
-- nvim-lspconfig ships configs in lsp/ — vim.lsp.enable() activates them
vim.lsp.enable({
  "gopls",
  "ts_ls",        -- typescript-language-server
  "nil_ls",       -- nil (Nix)
  "pyright",
  "rust_analyzer",
  "yamlls",
  -- vscode-langservers-extracted bundle:
  "jsonls",
  "cssls",
  "html",
  "eslint",
})
