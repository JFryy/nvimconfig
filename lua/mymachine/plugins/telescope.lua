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
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown {
                    -- even more opts
                }
            }
        }
    }
    
    -- Set telescope as the picker for vim.ui.select
    require("telescope").load_extension("ui-select")
end

