return function()
    require('dashboard').setup {
        theme = 'hyper',
        config = {
            week_header = {
                enable = true,
            },
            shortcut = {
                { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                {
                    icon = ' ',
                    icon_hl = '@variable',
                    desc = 'Files',
                    group = 'Label',
                    action = 'FzfLua files',
                    key = 'f',
                },
                {
                    desc = ' Search',
                    group = 'DiagnosticHint',
                    action = 'FzfLua live_grep',
                    key = 's',
                },
                {
                    desc = ' Recent',
                    group = 'Number',
                    action = 'FzfLua oldfiles',
                    key = 'r',
                },
            },
            project = {
                enable = true,
                limit = 15,
                icon = '',
                label = '',
                action = function(path)
                    vim.cmd('cd ' .. path)
                    require('fzf-lua').files({ cwd = path })
                end
            },
            mru = {
                enable = true,
                limit = 10,
                icon = ' ',
                label = '',
                cwd_only = false
            },
        },
    }
end
