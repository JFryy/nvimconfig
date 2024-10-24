-- space as leader
vim.g.mapleader = ' '

-- non-plugin keymaps
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)

-- aliases
vim.cmd('command W w')
vim.cmd('command Q q')

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>rr', builtin.command_history, {})
vim.keymap.set('n','<leader>gg', builtin.git_status, {})
vim.keymap.set('n','<leader>gc', builtin.git_commits, {})
vim.keymap.set('n','<leader>bb', builtin.buffers, {})

-- REPLACE ALL helper:
-- Find string in all files using Telescope and populate quick fix list using
-- ctrl + q
-- :cdo %s/oldstring/newstring/g | update

-- nvim-tree
vim.api.nvim_set_keymap('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true })

-- toggle-term
vim.api.nvim_set_keymap('n', '<leader>tt', ':ToggleTerm dir=git_dir size=20 <CR>', { noremap = true, silent = true })

-- local pilot
vim.api.nvim_set_keymap('v', '<leader>ll', ':<C-U>CodePosseGenVisual<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ll', ':<C-U>CodePosseGenWin<CR>', { noremap = true, silent = true })
