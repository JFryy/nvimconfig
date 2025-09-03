return function()
    require('dashboard').setup {
        theme = 'hyper',
        config = {
            header = {
                '___________.__                 .__                  ___________.__          __    _________ .__               .__          ',
                '\\__    ___/|__| _____   ____   |__| ______ _____    \\_   _____/|  | _____ _/  |_  \\_   ___ \\|__|______   ____ |  |   ____  ',
                '  |    |   |  |/     \\_/ __ \\  |  |/  ___/ \\__  \\    |    __)  |  | \\__  \\\\   __\\ /    \\  \\/|  \\_  __ \\_/ ___\\|  | _/ __ \\ ',
                '  |    |   |  |  Y Y  \\  ___/  |  |\\___ \\   / __ \\_  |     \\   |  |__/ __ \\|  |   \\     \\___|  ||  | \\/\\  \\___|  |_\\  ___/ ',
                '  |____|   |__|__|_|  /\\___  > |__/____  > (____  /  \\___  /   |____(____  /__|    \\______  /__||__|    \\___  >____/\\___  >',
                '                    \\/     \\/          \\/       \\/       \\/              \\/               \\/                \\/          ',
                '                                                                                                                           ',
            },
            week_header = {
                enable = false,
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
