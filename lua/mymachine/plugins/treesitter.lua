return function()
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
        highlight = { enable = true, additional_vim_regex_highlighting = true },
        context_commentstring = { enable = true, enable_autocmd = true },
        matchup = { enable = true },
        textobjects = {
            enable = true,
            lookahead = true,
            select = {
                enable = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ab"] = "@block.outer",
                    ["ib"] = "@block.inner",
                },
            },
        }
    })
end 