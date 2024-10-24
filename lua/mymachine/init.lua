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
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "go",
                    "bash",
                    "python",
                    "rust",
                    "lua",
                    "helm",
                    "javascript",
                    "typescript",
                    "terraform",
                },
                sync_install = true,
                indent = { enable = true },
                highlight = { enable = true, additional_vim_regex_highlighting = true }, -- enable highlighting with additional regex options
                context_commentstring = { enable = true, enable_autocmd = true },        -- enable context comment string with autocmd option
                matchup = { enable = true },                                             -- enable the matchup plugin for better parentheses matching
                textobjects = {
                    enable = true,
                    lookahead = true,
                    select = {
                        enable = true,
                        keymaps = {
                            ["af"] = "@function.outer", -- select outer function
                            ["if"] = "@function.inner", -- select inner function
                            ["ab"] = "@block.outer",    -- select outer block
                            ["ib"] = "@block.inner",    -- select inner block
                        },
                    },
                }
            })
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        init = function()
            -- Set up Telescope with custom options
            require('telescope').setup {
                defaults = {
                    file_ignore_patterns = { '%.git/', '%.svn/', 'venv/', '%.venv/' }
                },
                pickers = {
                    find_files = {
                        hidden = false, -- Don't search for hidden files (dotfiles)
                    },
                },
            }
        end,
    },
    -- neotree
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        }
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
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                formatting = lsp_zero.cmp_format(),
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-j>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-k>'] = cmp.mapping.scroll_docs(4),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                    ['<tab>'] = cmp.mapping.confirm({
                        -- what options do I have for this?
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                }),
                experimental = {
                    ghost_text = true
                }
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
                    vim.lsp.buf.format({ async = true, timeout_ms = 5000 })
                end, opts)
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            require('mason-lspconfig').setup({
                ensure_installed = {
                    'bashls',
                    'gopls',
                    'pyright',
                },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                }
            })
        end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        config = function()
            require("gitsigns").setup()
        end,
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = { persist_size = true },
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {},
        dependencies = { 'nvim-treesitter/nvim-treesitter' }
    },
    --    {
    --        dir = "~/.config/nvim/lua/codeposse/",
    --        config = function()
    --            require("codeposse").setup({
    --                -- Add any setup options or configuration here
    --            })
    --        end
    --    },
    {
        'altermo/ultimate-autopair.nvim',
        event = { 'InsertEnter', 'CmdlineEnter' },
        branch = 'v0.6', --recommended as each new version will have breaking changes
        opts = {}
    },
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        event = {
            -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
            -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
            -- refer to `:h file-pattern` for more examples
            "BufReadPre " .. vim.fn.expand "~" .. "/md_vault/*.md",
            "BufNewFile " .. vim.fn.expand "~" .. "/md_vault/*.md",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",

        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "~/md_vault/",
                },
            },

        },
    }
})
