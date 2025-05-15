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
        if vim.bo[term_buf].buftype ~= 'terminal' then
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
