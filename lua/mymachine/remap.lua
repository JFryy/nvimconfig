-- space as leader
vim.g.mapleader = ' '


-- non-plugin keymaps
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)
vim.cmd('command W w')
vim.cmd('command Q q')

-- telscope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- nvim-tree
vim.api.nvim_set_keymap('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true })

-- toggle-term
vim.api.nvim_set_keymap('n', '<leader>tt', ':ToggleTerm dir=git_dir size=20 <CR>', { noremap = true, silent = true })

