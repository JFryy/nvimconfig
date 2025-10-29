-- ============================================================================
-- CUSTOM FANCY TERMINAL TOGGLE
-- ============================================================================
-- A sleek, custom terminal implementation without external dependencies
-- Features:
--   - Smooth floating window with rounded borders
--   - Multiple terminal instances (indexed)
--   - Persistent terminals that survive toggles
--   - Beautiful animations and styling
--   - Smart window sizing
-- ============================================================================

local M = {}

-- Terminal state management
M.terminals = {}
M.current_term_id = 1

-- Configuration
M.config = {
    size = {
        width = 0.85,   -- 85% of editor width
        height = 0.85,  -- 85% of editor height
    },
    border = "rounded", -- "single", "double", "rounded", "solid", "shadow"
    winblend = 10,      -- transparency (0-100, 0 is opaque)
    highlights = {
        border = "FloatBorder",
        background = "Normal",
    },
}

-- Create a beautiful floating window
local function create_floating_window(bufnr)
    local width = math.floor(vim.o.columns * M.config.size.width)
    local height = math.floor(vim.o.lines * M.config.size.height)

    -- Calculate center position
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- Window options with fancy styling
    local win_opts = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = M.config.border,
        title = " Terminal ",
        title_pos = "center",
    }

    -- Create the window
    local win_id = vim.api.nvim_open_win(bufnr, true, win_opts)

    -- Apply highlights and transparency
    vim.api.nvim_win_set_option(win_id, 'winblend', M.config.winblend)
    vim.api.nvim_win_set_option(win_id, 'winhighlight',
        'Normal:' .. M.config.highlights.background ..
        ',FloatBorder:' .. M.config.highlights.border)

    return win_id
end

-- Get or create a terminal buffer
local function get_or_create_terminal(term_id)
    term_id = term_id or M.current_term_id

    -- Check if terminal already exists
    if M.terminals[term_id] then
        local term = M.terminals[term_id]
        -- Verify buffer is still valid
        if vim.api.nvim_buf_is_valid(term.bufnr) then
            return term
        end
    end

    -- Create new terminal buffer
    local bufnr = vim.api.nvim_create_buf(false, true)

    -- Set buffer options
    vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'hide')
    vim.api.nvim_buf_set_option(bufnr, 'filetype', 'terminal')

    -- Store terminal info
    M.terminals[term_id] = {
        bufnr = bufnr,
        win_id = nil,
        job_id = nil,
    }

    return M.terminals[term_id]
end

-- Start terminal job if not already running
local function start_terminal_job(term)
    if term.job_id and vim.api.nvim_buf_is_valid(term.bufnr) then
        return term.job_id
    end

    -- Get the shell from vim options
    local shell = vim.o.shell

    -- Open terminal in buffer
    vim.api.nvim_buf_call(term.bufnr, function()
        term.job_id = vim.fn.termopen(shell, {
            on_exit = function()
                -- Clean up on exit
                if term.win_id and vim.api.nvim_win_is_valid(term.win_id) then
                    vim.api.nvim_win_close(term.win_id, true)
                end
                M.terminals[M.current_term_id] = nil
            end
        })
    end)

    return term.job_id
end

-- Toggle terminal visibility
function M.toggle(term_id)
    term_id = term_id or M.current_term_id
    local term = get_or_create_terminal(term_id)

    -- Check if terminal window is currently open
    if term.win_id and vim.api.nvim_win_is_valid(term.win_id) then
        -- Close the window
        vim.api.nvim_win_close(term.win_id, true)
        term.win_id = nil
    else
        -- Create and show the window
        term.win_id = create_floating_window(term.bufnr)

        -- Start terminal job if needed
        if not term.job_id then
            start_terminal_job(term)
        end

        -- Enter insert mode automatically
        vim.cmd('startinsert')

        -- Set up keymaps for this terminal buffer
        local opts = { noremap = true, silent = true, buffer = term.bufnr }

        -- <leader>t to toggle from terminal mode
        vim.keymap.set('t', '<leader>t', function()
            M.toggle(term_id)
        end, opts)

        -- Easy escape from terminal mode
        vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', opts)
        vim.keymap.set('t', 'jk', '<C-\\><C-n>', opts)

        -- Navigation between windows in terminal mode
        vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', opts)
        vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', opts)
        vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', opts)
        vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', opts)
    end
end

-- Create a new terminal instance
function M.new_terminal()
    -- Find next available terminal ID
    local new_id = 1
    while M.terminals[new_id] do
        new_id = new_id + 1
    end
    M.current_term_id = new_id
    M.toggle(new_id)
end

-- List all terminal instances
function M.list_terminals()
    local active = {}
    for id, term in pairs(M.terminals) do
        if vim.api.nvim_buf_is_valid(term.bufnr) then
            table.insert(active, id)
        end
    end

    if #active == 0 then
        print("No active terminals")
        return
    end

    print("Active terminals: " .. table.concat(active, ", "))
    print("Current terminal: " .. M.current_term_id)
end

-- Switch to a specific terminal
function M.switch_to(term_id)
    if not M.terminals[term_id] then
        print("Terminal " .. term_id .. " does not exist")
        return
    end
    M.current_term_id = term_id
    M.toggle(term_id)
end

-- Setup function
function M.setup(opts)
    opts = opts or {}
    M.config = vim.tbl_deep_extend("force", M.config, opts)

    -- Create user commands
    vim.api.nvim_create_user_command('TerminalToggle', function()
        M.toggle()
    end, { desc = "Toggle terminal" })

    vim.api.nvim_create_user_command('TerminalNew', function()
        M.new_terminal()
    end, { desc = "Create new terminal" })

    vim.api.nvim_create_user_command('TerminalList', function()
        M.list_terminals()
    end, { desc = "List all terminals" })

    vim.api.nvim_create_user_command('TerminalSelect', function(cmd_opts)
        local term_id = tonumber(cmd_opts.args)
        if term_id then
            M.switch_to(term_id)
        else
            M.list_terminals()
        end
    end, { nargs = '?', desc = "Switch to terminal by ID" })
end

return M
