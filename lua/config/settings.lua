-- Use spaces instead of tab
vim.opt.expandtab = true

-- 1 tab = 4 spaces
vim.opt.tabstop = 4

-- Backspace deletes 4 spaces
vim.opt.softtabstop = 4

-- Auto-indent width
vim.opt.shiftwidth = 4

-- Smart auto-indent
vim.opt.smartindent = true

-- Line Numbers
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers

-- Other recommended basics
vim.opt.wrap = false          -- No line wrapping
vim.opt.termguicolors = true  -- True color support

vim.opt.showmode = false
vim.opt.showcmd = false

vim.opt.swapfile = false

vim.opt.syntax = on

--vim.keymap.set('n', '<leader>tt', ':term<CR>', {})
