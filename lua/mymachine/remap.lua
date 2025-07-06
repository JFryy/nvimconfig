-- space as leader
vim.g.mapleader = ' '

-- Aliases
vim.cmd('command! W w')
vim.cmd('command! Q q')

-- File Explorer
vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true, desc = "Toggle Neo-tree" })
vim.keymap.set('n', '<leader>ex', ':Explore<CR>', { desc = "Delete buffer" })

-- FZF-lua
local fzf = require('fzf-lua')
vim.keymap.set('n', '<leader>ff', fzf.files, { desc = "Find files" })
vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = "Live grep" })
vim.keymap.set('n', '<leader>rr', fzf.command_history, { desc = "Command history" })
vim.keymap.set('n', '<leader>gg', fzf.git_status, { desc = "Git status" })
vim.keymap.set('n', '<leader>gc', fzf.git_commits, { desc = "Git commits" })
vim.keymap.set('n', '<leader>bb', fzf.buffers, { desc = "Buffers" })

-- Spectre
vim.keymap.set('n', '<leader>fr', ':lua require("spectre").open()<CR>', { noremap = true, silent = true, desc = "Open Spectre" })

-- Buffer navigation
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = "Next buffer" })
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = "Previous buffer" })

local exit_insert_mode_keys = { 'jk', 'jj', 'kk' }
for _, keys in ipairs(exit_insert_mode_keys) do
    vim.keymap.set('i', keys, '<Esc>', { noremap = true, silent = true, desc = "Exit insert mode" })
end


-- code companion
vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })

vim.cmd([[cab cc CodeCompanion]])

vim.api.nvim_set_keymap('n', '<leader>cc', ':CodeCompanion<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>cc', ':CodeCompanion<CR>', { noremap = true, silent = true })
-- REPLACE ALL helper:
-- Find string in all files using Telescope and populate quick fix list using
-- ctrl + q
-- :cdo %s/oldstring/newstring/g | update
