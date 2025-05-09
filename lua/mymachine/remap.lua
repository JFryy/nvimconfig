-- REPLACE ALL helper:
-- Find string in all files using Telescope and populate quick fix list using
-- ctrl + q
-- :cdo %s/oldstring/newstring/g | update
-- space as leader
vim.g.mapleader = ' '

-- Aliases
vim.cmd('command! W w')
vim.cmd('command! Q q')

-- File Explorer
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true, desc = "Toggle Neo-tree" })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
vim.keymap.set('n', '<leader>rr', builtin.command_history, { desc = "Command history" })
vim.keymap.set('n', '<leader>gg', builtin.git_status, { desc = "Git status" })
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Git commits" })
vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = "Buffers" })

-- Buffer navigation
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = "Next buffer" })
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = "Previous buffer" })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = "Delete buffer" })

-- Window management
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', { desc = "Vertical split" })
vim.keymap.set('n', '<leader>sh', ':split<CR>', { desc = "Horizontal split" })
vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = "Equalize splits" })
vim.keymap.set('n', '<leader>sx', ':close<CR>', { desc = "Close split" })

-- Exit insert mode helpers
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true, desc = "Exit insert mode" })
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true, desc = "Exit insert mode" })
vim.keymap.set('i', 'kk', '<Esc>', { noremap = true, silent = true, desc = "Exit insert mode" })

-- lua for a toggle-able terminal
local term_buf = nil
local term_win = nil
local function toggle_centered_terminal()
    if term_win and vim.api.nvim_win_is_valid(term_win) then
        vim.api.nvim_win_close(term_win, true)
        term_win = nil
    else
        if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
            term_buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
        end
        local width = vim.o.columns
        local height = vim.o.lines
        local win_height = math.floor(height * 0.7)
        local win_width = math.floor(width * 0.7)
        local row = math.floor((height - win_height) / 2)
        local col = math.floor((width - win_width) / 2)
        term_win = vim.api.nvim_open_win(term_buf, true, {
            relative = 'editor',
            width = win_width,
            height = win_height,
            row = row,
            col = col,
            style = 'minimal',
            border = 'rounded',
        })
        if vim.api.nvim_buf_get_option(term_buf, 'buftype') ~= 'terminal' then
            vim.fn.termopen(vim.o.shell)
        end
        vim.api.nvim_buf_set_keymap(term_buf, 't', '<leader>tt', [[<C-\><C-n>]], { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(term_buf, 't', '<Esc><Esc>', [[<Cmd>bwipeout!<CR>]],
            { noremap = true, silent = true })
        vim.cmd('startinsert')
    end
end
vim.api.nvim_create_user_command('Tabaterm', toggle_centered_terminal, {})
vim.keymap.set('n', '<leader>tt', ':Tabaterm<CR>', { noremap = true, silent = true, desc = "Toggle terminal" })

-- Paste without yanking
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

-- Clear search highlight
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight" })
