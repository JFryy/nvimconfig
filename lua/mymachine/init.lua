local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
-- lazy plugins
require("lazy").setup({
    -- treesitter for syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {}, -- language list
                sync_install = true,
                highlight = { enable = true },
                indent = { enable = true },
                context_commentstring = { enable = true },
            })
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    -- neotree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    },
    -- lsp-zero itself
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    -- mason config recommended by lsp-zero
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },
    {
        'mfussenegger/nvim-lint',
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                formatting = lsp_zero.cmp_format(),
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                    -- configure mapping for tab to accept the snippet
                    ['<tab>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                })
            })
        end
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
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
                local opts = { buffer = bufnr }

                vim.keymap.set({ 'n', 'x' }, 'gq', function()
                    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
                end, opts)
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            require('mason-lspconfig').setup({
                ensure_installed = {
                    'bashls',
                    'dockerls',
                    'gopls',
                    'pyright',
                    'rust_analyzer',
                    'vimls',
                },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                }
            })
        end
    },
    -- colorscheme
    {
        {
            'rose-pine/neovim',
            name = 'rose-pine',
            config = function()
                vim.cmd('colorscheme rose-pine')
            end
        },
    },
    -- git line diff
    {
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        config = function()
            require("gitsigns").setup()
        end,
    },
    -- better terminal?
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = { persist_size = true },
    }
--    {
--        dir = "~/.config/nvim/lua/localpilot/",
--        config = function()
--            require("localpilot").setup({
--                -- Add any setup options or configuration here
--            })
--        end
--    }
})
