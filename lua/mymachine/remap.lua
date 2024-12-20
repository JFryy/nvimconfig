-- REPLACE ALL helper:
-- Find string in all files using Telescope and populate quick fix list using
-- ctrl + q
-- :cdo %s/oldstring/newstring/g | update
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
vim.keymap.set('n', '<leader>gg', builtin.git_status, {})
vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>bb', builtin.buffers, {})


-- nvim-tree
vim.api.nvim_set_keymap('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true })

-- local pilot
vim.api.nvim_set_keymap('v', '<leader>ll', ':<C-U>CodePosseGenVisual<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ll', ':<C-U>CodePosseGenWin<CR>', { noremap = true, silent = true })


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
        vim.api.nvim_buf_set_keymap(term_buf, 't', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(term_buf, 't', '<Esc><Esc>', [[<Cmd>bwipeout!<CR>]],
            { noremap = true, silent = true })
        vim.cmd('startinsert')
    end
end

vim.api.nvim_create_user_command('Tabaterm', toggle_centered_terminal, {})
vim.api.nvim_set_keymap('n', '<leader>tt', ':Tabaterm<CR>', { noremap = true, silent = true })
