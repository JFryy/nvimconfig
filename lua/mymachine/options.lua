-- Refresh

-- set autoread
-- autocmd BufEnter,CursorHold,CursorHoldI * checktime
vim.cmd([[
  augroup autoread
    autocmd!
    autocmd BufEnter,CursorHold,CursorHoldI * checktime
  augroup END
]])

-- Indentation
vim.opt.tabstop = 4        -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4     -- Number of spaces to use for each step of (auto)indent
vim.opt.softtabstop = 4    -- Makes <Tab> feel consistent when editing
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.smartindent = true -- Smart autoindenting on new lines

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- UI
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'             -- Always show the sign column
vim.opt.wrap = false
vim.opt.scrolloff = 8                  -- Keep 8 lines visible above/below cursor
vim.opt.sidescrolloff = 8              -- Keep 8 columns visible left/right of cursor
vim.opt.splitbelow = true              -- Horizontal splits go below
vim.opt.splitright = true              -- Vertical splits go to the right
vim.opt.showcmd = false                -- Don't show keypresses
vim.cmd('let g:gitblame_delay = 5000') -- Git blame delay

-- Undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('data') .. '/undo'
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

-- Clipboard
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard

-- Performance
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.lazyredraw = true

-- Search
vim.opt.ignorecase = true -- Ignore case when searching...
vim.opt.smartcase = true  -- ...unless capital letters are used

---- Disable LSP diagnostics
--vim.diagnostic.config({
--    signs = false
--})

-- disable virtual_text (inline) diagnostics and use floating window
-- format the message such that it shows source, message and
-- the error code. Show the message with <space>e
vim.o.updatetime = 250 -- Faster CursorHold
vim.cmd([[
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- vim.opt.shortmess:append('c') -- Don't show completion messages
vim.o.mouse = ''  -- Disable mouse support in Neovim
-- Configure diagnostic signs and display
vim.diagnostic.config({
    virtual_text = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
        },
    },
    float = {
        border = "single",
        format = function(diagnostic)
            return string.format(
                "%s (%s) [%s]",
                diagnostic.message,
                diagnostic.source,
                diagnostic.code or diagnostic.user_data.lsp.code
            )
        end,
    },
})

-- Customize LSP hover window: rounded border and max size
vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({
    max_width = 80,
    max_height = 20,
})

-- Add manual hover keybinding (commonly K)
vim.keymap.set('n', 'K', function()
    vim.lsp.buf.hover()
end, { desc = 'Show LSP hover documentation' })
