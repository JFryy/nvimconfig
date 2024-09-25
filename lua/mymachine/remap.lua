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
vim.keymap.set('n', '<leader>r', builtin.command_history, {})
vim.keymap.set('n','<leader>gg', builtin.git_status, {})
vim.keymap.set('n','<leader>gc', builtin.git_commits, {})

-- nvim-tree
vim.api.nvim_set_keymap('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true })

-- toggle-term
vim.api.nvim_set_keymap('n', '<leader>tt', ':ToggleTerm dir=git_dir size=20 <CR>', { noremap = true, silent = true })

-- local pilot
vim.api.nvim_set_keymap('v', '<leader>ll', ':<C-U>LocalPilotGenVisual<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ll', ':<C-U>LocalPilotGenWin<CR>', { noremap = true, silent = true })
