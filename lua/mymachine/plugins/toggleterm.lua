return function()
    require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = false,
        direction = 'horizontal',
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
            border = 'curved',
            winblend = 3,
        },
        highlights = {
            Normal = {
                link = 'Normal'
            },
            NormalFloat = {
                link = 'NormalFloat'
            },
            FloatBorder = {
                link = 'FloatBorder'
            },
        },
    })

    -- Terminal window mappings for easy navigation
    function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end

    vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

    -- Custom terminal configurations
    local Terminal = require('toggleterm.terminal').Terminal

    -- htop terminal
    local htop = Terminal:new({
        cmd = "htop",
        direction = "float",
        float_opts = {
            border = "double",
        },
        on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
    })

    function _htop_toggle()
        htop:toggle()
    end

    -- Key mappings
    vim.api.nvim_set_keymap("n", "<leader>h", "<cmd>lua _htop_toggle()<CR>", { noremap = true, silent = true })

    -- Additional useful mappings
    vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>",
        { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>",
        { noremap = true, silent = true })
end

