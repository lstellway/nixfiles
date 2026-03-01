-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- Backup / swap
vim.opt.backupdir = { "/tmp" }
vim.opt.directory = { "/tmp" }

-- Splits open right and below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Statusline / tabline always visible
vim.opt.laststatus = 2
vim.opt.showtabline = 2

-- Backspace over indent, EOL, and start of insert
vim.opt.backspace = { "indent", "eol", "start" }

-- Scroll cursor stays vertically centered
vim.opt.scrolloff = 999

-- Color column guide
vim.opt.colorcolumn = "80"

-- Line wrapping: allow h/l and arrow keys to cross line boundaries
vim.opt.whichwrap:append("<,>,h,l")

-- Regex engine: use NFA (avoids slow TypeScript highlighting)
vim.opt.regexpengine = 0

-- netrw: open preview in vertical split
vim.g.netrw_preview = 1
vim.g.netrw_alto = 0
-- make buffer tab visible
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro buflisted"

-- Indentation: 2-space tabs for JS/TS/PHP
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "php" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
    vim.opt_local.smarttab = true
  end,
})

-- plist files: treat as XML
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.plist",
  command = "set filetype=xml",
})

-- User commands
vim.api.nvim_create_user_command("Indentation", function(opts)
  local size = tonumber(opts.args) or 2
  vim.opt_local.shiftwidth = size
  vim.opt_local.tabstop = size
  vim.opt_local.softtabstop = size
  vim.opt_local.expandtab = true
  vim.opt_local.smarttab = true
end, { nargs = "?" })

vim.api.nvim_create_user_command("ClearSwap", function()
  vim.fn.system("rm -f /tmp/*.swp")
end, {})

vim.api.nvim_create_user_command("RelativePath", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
end, {})

vim.api.nvim_create_user_command("AbsolutePath", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end, {})
