return function()
    require('nvim-treesitter.install').prefer_git = true
    require('nvim-treesitter.config').setup({
        ensure_installed = {
            "lua",
            "vim",
            "vimdoc",
            "query",
            "javascript",
            "typescript",
            "python",
            "rust",
            "go",
            "html",
            "css",
            "json",
            "markdown",
            "bash",
        },
        
        sync_install = false,
        auto_install = true,
        
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        
        indent = {
            enable = true,
        },
        
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
            },
        },
    })
end