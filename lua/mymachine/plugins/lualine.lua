return function()
    require('lualine').setup({
        options = {
            theme = 'catppuccin',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            globalstatus = true,
            disabled_filetypes = { statusline = { 'dashboard', 'alpha' } },
        },
        sections = {
            lualine_a = {
                {
                    'mode',
                    fmt = function(str)
                        local mode_map = {
                            NORMAL = ' N ',
                            INSERT = ' I ',
                            VISUAL = ' V ',
                            ['V-LINE'] = ' VL ',
                            ['V-BLOCK'] = ' VB ',
                            COMMAND = ' C ',
                            REPLACE = ' R ',
                            SELECT = ' S ',
                            TERMINAL = ' T ',
                        }
                        return mode_map[str] or ' ' .. str:sub(1, 1) .. ' '
                    end,
                    color = { gui = 'bold' },
                }
            },
            lualine_b = {
                {
                    'branch',
                    icon = '󰊢',
                    color = { gui = 'bold' },
                    fmt = function(str)
                        if str == '' then
                            return ''
                        end
                        return str:len() > 25 and str:sub(1, 22) .. '...' or str
                    end,
                },
                {
                    'diff',
                    symbols = {
                        added = '+',
                        modified = '~',
                        removed = '-',
                    },
                    diff_color = {
                        added = { fg = '#98be65' },
                        modified = { fg = '#ECBE7B' },
                        removed = { fg = '#ec5f67' },
                    },
                }
            },
            lualine_c = {
                {
                    'filename',
                    path = 1,
                    file_status = true,
                    symbols = {
                        modified = ' ',
                        readonly = ' ',
                        unnamed = '[Untitled]',
                        newfile = '[New]',
                    },
                    color = { gui = 'bold' },
                    fmt = function(str)
                        if str == '' then
                            return '󰈔 [No File]'
                        end
                        return '󰈔 ' .. str
                    end,
                },
                {
                    'filesize',
                    cond = function()
                        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
                    end,
                    color = { fg = '#6c7086' },
                }
            },
            lualine_x = {
                {
                    'diagnostics',
                    sources = { 'nvim_diagnostic' },
                    symbols = {
                        error = ' ', -- nf-fa-times-circle
                        warn = ' ', -- nf-fa-exclamation-triangle
                        info = ' ', -- nf-fa-info-circle
                        hint = ' ', -- nf-fa-question-circle
                    },
                    diagnostics_color = {
                        error = { fg = '#ec5f67' },
                        warn = { fg = '#ECBE7B' },
                        info = { fg = '#51afef' },
                        hint = { fg = '#98be65' },
                    },
                    update_in_insert = false,
                },
                {
                    function()
                        local clients = vim.lsp.get_clients({ bufnr = 0 })
                        if #clients == 0 then
                            return ''
                        end
                        local names = {}
                        for _, client in ipairs(clients) do
                            table.insert(names, client.name)
                        end
                        return '󰒋 ' .. table.concat(names, ', ')
                    end,
                    color = { fg = '#a9a1e1', gui = 'bold' },
                },
                {
                    'encoding',
                    fmt = string.upper,
                    cond = function()
                        return vim.opt.encoding:get() ~= 'utf-8'
                    end,
                    color = { fg = '#6c7086' },
                },
                {
                    'fileformat',
                    symbols = {
                        unix = '',
                        dos = '',
                        mac = '',
                    },
                    color = { fg = '#6c7086' },
                },
                {
                    'filetype',
                    colored = true,
                    icon_only = false,
                    color = { gui = 'bold' },
                },
            },
            lualine_y = {
                {
                    'progress',
                    fmt = function(str)
                        return '' .. str
                    end,
                    color = { gui = 'bold' },
                }
            },
            lualine_z = {
                {
                    'location',
                    fmt = function(str)
                        return '󰍉 ' .. str
                    end,
                    color = { gui = 'bold' },
                }
            }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        extensions = { 'neo-tree', 'oil' }
    })
end