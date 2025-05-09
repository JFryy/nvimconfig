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
        config = require("mymachine.plugins.treesitter"),
    },
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
        dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim", }
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        config = function()
            require("gitsigns").setup()
        end,
    },
    { 'MeanderingProgrammer/render-markdown.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter' } },
    { "catppuccin/nvim",                           name = "catppuccin",                                 priority = 1000 },
    -- Avante
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false,
        opts = require("mymachine.plugins.avante").opts,
        build = "make",
        dependencies = require("mymachine.plugins.avante").dependencies,
    },
})
