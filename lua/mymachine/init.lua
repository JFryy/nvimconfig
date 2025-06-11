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
    -- the one and only
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = require("mymachine.plugins.treesitter"),
    },
    -- the one and only
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        init = require("mymachine.plugins.telescope"),
    },
    -- lsp-zero itself
    {
        'VonHeikemen/lsp-zero.nvim',
        lazy = true,
        config = false,
        init = function()
            vim.g.lsp_zero_extend_cmp = 1
            vim.g.lsp_zero_extend_lspconfig = 1
        end,
    },
    -- mason config recommended by lsp-zero
    { 'williamboman/mason.nvim', lazy = false, config = true, },
    { 'mfussenegger/nvim-lint' },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
        },
        config = require("mymachine.plugins.cmp"),
    },
    -- LSP Configuration grabbed from lsp-zero
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
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
            require("neo-tree").setup({})
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
    -- markdown rendering in place
    { 'MeanderingProgrammer/render-markdown.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter' } },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                transparent_background = true,
                term_colors = true,
                styles = {
                    comments = { "italic" },
                    functions = { "italic" },
                    keywords = { "italic" },
                    strings = { "italic" },
                    variables = { "italic" },
                },
            })
            vim.cmd.colorscheme 'catppuccin'
        end
    },
    {
        "olimorris/codecompanion.nvim",
        opts = {},
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },
    -- unfortunately needed
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
    },
    -- find replace helper
    {
        'nvim-pack/nvim-spectre',
        config = function()
            require('spectre').setup()
        end,
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
        config = function()
            require('keytrail').setup()
        end
    },
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                config = {
                    center = {
                        {
                            icon = '',
                            icon_hl = 'group',
                            desc = 'description',
                            desc_hl = 'group',
                            key = 'shortcut key in dashboard buffer not keymap !!',
                            key_hl = 'group',
                            key_format = ' [%s]', -- `%s` will be substituted with value of `key`
                            action = '',
                        },
                    },
                    footer = {

                        'My Amazingly Bloated Text Editing Experience!!!',
                    },
                    vertical_center = false, -- Center the Dashboard on the vertical (from top to bottom)
                }                            -- config
            }
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
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
    }
})
