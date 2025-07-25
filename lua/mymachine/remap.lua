-- ============================================================================
-- NEOVIM KEYMAP CONFIGURATION
-- ============================================================================
-- This file contains all custom keymaps for enhanced workflow efficiency
-- Leader key: <Space>
--
-- COMPREHENSIVE KEYMAP REFERENCE:
-- ==============================
--
-- COMMAND ALIASES:
--   :W              → Save file (:w)
--   :Q              → Quit (:q)
--   :cc             → Code Companion command alias
--
-- FILE EXPLORATION:
--   Ctrl+n          → Toggle Neo-tree file explorer
--   <leader>ex      → Open native file explorer
--
-- FUZZY FINDING (FZF-lua):
--   <leader>ff      → Find files by name
--   <leader>fg      → Live grep search in files
--   <leader>r          → Command history
--   Ctrl+g          → Git status
--   <leader>gc      → Browse git commits
--   Ctrl+b          → Switch between open buffers
--   F1-F6           → FZF preview controls (help, fullscreen, wrap, etc.)
--   Shift+Up/Down   → FZF preview scroll
--   Ctrl+z          → Abort FZF search
--
-- BUFFER NAVIGATION:
--   Ctrl+.          → Next buffer
--   Ctrl+,          → Previous buffer
--
-- INSERT MODE ESCAPES:
--   jk, jj, kk      → Exit insert mode
--
-- LSP (Language Server):
--   gd              → Go to definition
--   gD              → Go to declaration
--   gr              → Show references
--   gi              → Go to implementation
--   K               → Show hover documentation
--   Ctrl+k          → Show signature help
--   <leader>wa      → Add workspace folder
--   <leader>wr      → Remove workspace folder
--   <leader>wl      → List workspace folders
--   <leader>D       → Go to type definition
--   gq              → Format buffer
--
-- COMPLETION (Blink.cmp):
--   Ctrl+space      → Show/hide completion menu
--   Ctrl+e          → Hide completion menu
--   Ctrl+y          → Select and accept completion
--   Tab             → Accept completion
--   Shift+Tab       → Navigate backwards in snippet
--   Up/Down         → Navigate completion items
--   Ctrl+b/f        → Scroll documentation
--   Enter           → Accept completion
--
-- TERMINAL (ToggleTerm):
--   Ctrl+\          → Toggle terminal
--   <leader>tf      → Toggle floating terminal
--   <leader>th      → Toggle horizontal terminal
--   <leader>tv      → Toggle vertical terminal
--   <leader>h       → Toggle htop in floating terminal
--   Esc/jk          → Exit terminal mode (in terminal)
--   Ctrl+h/j/k/l    → Navigate windows (in terminal)
--
-- MOTION & SEARCH (Flash.nvim):
--   s               → Flash jump
--   S               → Flash treesitter
--
-- COMMENTING (Comment.nvim):
--   gcc             → Toggle line comment
--   gc              → Toggle comment for selection (visual)
--   gbc             → Toggle block comment
--   gb              → Toggle block comment for selection (visual)
--
-- AI CODE COMPANION:
--   Ctrl+a          → AI actions menu
--   <LocalLeader>a  → Toggle AI chat
--   <leader>cc      → Start Code Companion
--   Ctrl+s          → Accept Copilot suggestion
--
-- DASHBOARD SHORTCUTS:
--   u               → Update plugins (Lazy update)
--   f               → Find files (FzfLua files)
--   s               → Search text (FzfLua live_grep)
--   r               → Recent files (FzfLua oldfiles)
--
-- SEARCH & REPLACE WORKFLOW:
--   1. Use <leader>fg to find text across files
--   2. Press Ctrl+q in results to populate quickfix list
--   3. Run: :cdo %s/oldstring/newstring/g | update
-- ============================================================================

-- space as leader
vim.g.mapleader = ' '

-- ============================================================================
-- COMMAND ALIASES
-- ============================================================================
-- Common typos and shortcuts
vim.cmd('command! W w') -- :W saves file (common typo)
vim.cmd('command! Q q') -- :Q quits (common typo)

-- ============================================================================
-- FILE EXPLORATION
-- ============================================================================
-- Toggle file explorer and native explore
vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true, desc = "Toggle Neo-tree" })
vim.keymap.set('n', '<leader>ex', ':Explore<CR>', { desc = "Open native file explorer" })

-- ============================================================================
-- FUZZY FINDING WITH FZF-LUA
-- ============================================================================
-- Fast file and content searching
local fzf = require('fzf-lua')
vim.keymap.set('n', '<leader>ff', fzf.files, { desc = "Find files" })               -- Find files by name
vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = "Live grep" })            -- Search text content
vim.keymap.set('n', '<leader>r', fzf.command_history, { desc = "Command history" }) -- Recent commands
vim.keymap.set('n', '<C-g>', fzf.git_status, { desc = "Git status" })               -- Git file status
vim.keymap.set('n', '<leader>gc', fzf.git_commits, { desc = "Git commits" })        -- Browse commits
vim.keymap.set('n', '<C-b>', fzf.buffers, { desc = "Buffers" })                     -- Switch buffers

-- ============================================================================
-- BUFFER NAVIGATION
-- ============================================================================
-- Quick buffer switching
vim.keymap.set('n', '<C-.>', ':bnext<CR>', { desc = "Next buffer" })         -- Next buffer
vim.keymap.set('n', '<C-,>', ':bprevious<CR>', { desc = "Previous buffer" }) -- Previous buffer

-- ============================================================================
-- INSERT MODE ESCAPES
-- ============================================================================
-- Multiple ways to exit insert mode for comfort
local exit_insert_mode_keys = { 'jk', 'jj', 'kk' }
for _, keys in ipairs(exit_insert_mode_keys) do
    vim.keymap.set('i', keys, '<Esc>', { noremap = true, silent = true, desc = "Exit insert mode" })
end

-- ============================================================================
-- AI CODE COMPANION
-- ============================================================================
-- AI-powered coding assistance
vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>",
    { noremap = true, silent = true, desc = "AI Actions Menu" })
vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>",
    { noremap = true, silent = true, desc = "Toggle AI Chat" })

-- Command alias for Code Companion
vim.cmd([[cab cc CodeCompanion]])

-- Direct Code Companion access
vim.api.nvim_set_keymap('n', '<leader>cc', ':CodeCompanion<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>cc', ':CodeCompanion<CR>', { noremap = true, silent = true })
