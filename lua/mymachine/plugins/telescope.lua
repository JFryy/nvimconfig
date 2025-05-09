return function()
    require('telescope').setup {
        defaults = {
            file_ignore_patterns = { '%.git/', '%.svn/', 'venv/', '%.venv/' }
        },
        pickers = {
            find_files = {
                hidden = false,
            },
        },
    }
end 