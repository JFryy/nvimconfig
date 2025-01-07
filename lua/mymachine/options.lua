-- helpful things I forget sometimes:
-- gd = go to definition
-- C-o = go back
-- C-i = go forward
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.mouse = 'a'
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('data') .. '/undo'
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
vim.opt.clipboard = 'unnamedplus'
vim.cmd("colorscheme catppuccin")
