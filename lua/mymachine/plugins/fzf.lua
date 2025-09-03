return function()
    require('fzf-lua').setup {
        winopts = {
            height = 0.85,
            width = 0.80,
            preview = {
                default = 'bat',
                border = 'border',
                wrap = 'nowrap',
                hidden = 'nohidden',
                vertical = 'down:45%',
                horizontal = 'right:60%',
                layout = 'flex',
                flip_columns = 120,
            },
        },
        keymap = {
            builtin = {
                ["<F1>"] = "toggle-help",
                ["<F2>"] = "toggle-fullscreen",
                ["<F3>"] = "toggle-preview-wrap",
                ["<F4>"] = "toggle-preview",
                ["<F5>"] = "toggle-preview-ccw",
                ["<F6>"] = "toggle-preview-cw",
                ["<S-down>"] = "preview-page-down",
                ["<S-up>"] = "preview-page-up",
                ["<S-left>"] = "preview-page-reset",
            },
            fzf = {
                ["ctrl-z"] = "abort",
                ["ctrl-u"] = "unix-line-discard",
                ["ctrl-f"] = "half-page-down",
                ["ctrl-b"] = "half-page-up",
                ["ctrl-a"] = "beginning-of-line",
                ["ctrl-e"] = "end-of-line",
                ["alt-a"] = "toggle-all",
                ["f3"] = "toggle-preview-wrap",
                ["f4"] = "toggle-preview",
                ["shift-down"] = "preview-page-down",
                ["shift-up"] = "preview-page-up",
            },
        },
        previewers = {
            bat = {
                cmd = "bat",
                args = "--style=numbers,changes --color always",
                theme = 'Coldark-Dark',
            },
        },
        files = {
            file_ignore_patterns = { '%.git/', '%.svn/', 'venv/', '%.venv/' },
            git_icons = true,
            color_icons = true,
        },
        grep = {
            git_icons = true,
            color_icons = true,
        },
        git = {
            git_icons = true,
            color_icons = true,
        },
    }

    -- Set fzf-lua as the picker for vim.ui.select
    require('fzf-lua').register_ui_select()
end
