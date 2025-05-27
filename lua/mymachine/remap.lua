-- space as leader
vim.g.mapleader = ' '

-- Aliases
vim.cmd('command! W w')
vim.cmd('command! Q q')

-- File Explorer
vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true, desc = "Toggle Neo-tree" })
vim.keymap.set('n', '<leader>ex', ':Explore<CR>', { desc = "Delete buffer" })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
vim.keymap.set('n', '<leader>rr', builtin.command_history, { desc = "Command history" })
vim.keymap.set('n', '<leader>gg', builtin.git_status, { desc = "Git status" })
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Git commits" })
vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = "Buffers" })

-- Spectre
vim.keymap.set('n', '<leader>fr', ':lua require("spectre").open()<CR>', { noremap = true, silent = true, desc = "Open Spectre" })

-- Buffer navigation
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = "Next buffer" })
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = "Previous buffer" })

local exit_insert_mode_keys = { 'jk', 'jj', 'kk' }
for _, keys in ipairs(exit_insert_mode_keys) do
    vim.keymap.set('i', keys, '<Esc>', { noremap = true, silent = true, desc = "Exit insert mode" })
end

vim.keymap.set('n', '<leader>dd', ':Dashboard<CR>', { noremap = true, silent = true, desc = "dashboard shortcut" })

-- REPLACE ALL helper:
-- Find string in all files using Telescope and populate quick fix list using
-- ctrl + q
-- :cdo %s/oldstring/newstring/g | update
