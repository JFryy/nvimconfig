local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        branch = "main",
        config = function()
            require("nvim-treesitter").setup({
                highlight = {
                    enable = true,
                },
            })
            require'nvim-treesitter'.install { 'go', 'python', 'bash', 'lua', 'rust', 'javascript', 'typescript', 'html', 'css', 'json', 'yaml' }
            -- Start treesitter for specified filetypes
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {'go', 'python', 'bash', 'lua', 'rust', 'javascript', 'typescript', 'html', 'css', 'json', 'yaml' },
                callback = function()
                    vim.treesitter.start()
                end,
            })
        end,
    },
    {
        'ibhagwan/fzf-lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        init = require("mymachine.plugins.fzf"),
    },
    -- mason config
    { 'williamboman/mason.nvim', lazy = false,  config = true, },
    {
        'saghen/blink.cmp',
        event = 'InsertEnter',
        version = 'v0.*',
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        config = require("mymachine.plugins.cmp"),
    },
    -- LSP Configuration
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = require("mymachine.plugins.lspconfig"),
    },
    -- neotree
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        init = function()
            require("neo-tree").setup({
                filesystem = {
                    hijack_netrw_behavior = "disabled",
                },
            })
        end,
    },
    -- line diffs for vcs changes
    {
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        config = function()
            require("gitsigns").setup()
        end,
    },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000, opts = { flavour = "mocha" } },
    {
        "olimorris/codecompanion.nvim",
        opts = {},
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    -- better commenting: gcc for line, v<gc> for visual selection
    {
        'numToStr/Comment.nvim',
        event = "VeryLazy",
        config = function()
            require('Comment').setup()
        end
    },
    -- visual indent guides
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            require('ibl').setup({
                indent = {
                    char = '│',
                    tab_char = '│',
                },
                scope = { enabled = false },
            })
        end
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },
    -- note: better completion -- helps with lua globals from nvim config, more to be moved out
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        'jfryy/keytrail.nvim',
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    component_separators = { left = '|', right = '|' },
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
            })
        end
    },
    {
        'onsails/lspkind.nvim',
        config = function()
            require('lspkind').init({
                mode = 'symbol_text',
                preset = 'codicons',
                symbol_map = {
                    Text = "󰉿",
                    Method = "󰆧",
                    Function = "󰊕",
                    Constructor = "",
                    Field = "󰜢",
                    Variable = "󰀫",
                    Class = "󰠱",
                    Interface = "",
                    Module = "",
                    Property = "󰜢",
                    Unit = "󰑭",
                    Value = "󰎠",
                    Enum = "",
                    Keyword = "󰌋",
                    Snippet = "",
                    Color = "󰏘",
                    File = "󰈙",
                    Reference = "󰈇",
                    Folder = "󰉋",
                    EnumMember = "",
                    Constant = "󰏿",
                    Struct = "󰙅",
                    Event = "",
                    Operator = "󰆕",
                    TypeParameter = "",
                },
            })
        end
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    keymap = {
                        accept = "<C-s>",
                    },
                    auto_trigger = true
                },
            })
        end,
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        lazy = false,
    },
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = require("mymachine.plugins.dashboard"),
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },
    -- amongst your other plugins
    { 'akinsho/toggleterm.nvim', version = "*", config = require("mymachine.plugins.toggleterm") }
})
-- set catpuccin mocha as color scheme
vim.cmd.colorscheme("catppuccin")
-- temporary until hopefully added to mason
local systemd_lsp_path = '/Users/james/repos/systemd-lsp/target/release/systemd-lsp'
if vim.fn.filereadable(systemd_lsp_path) == 1 then
    vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.service", "*.mount", "*.device", "*.nspawn", "*.target", "*.timer" },
        callback = function()
            vim.bo.filetype = "systemd"
            vim.lsp.start({
                name = 'systemd_ls',
                cmd = { systemd_lsp_path },
                root_dir = vim.fn.getcwd(),
            })
        end,
    })
end
