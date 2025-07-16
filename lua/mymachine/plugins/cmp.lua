return function()
    require('blink.cmp').setup({
        keymap = {
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-e>'] = { 'hide' },
            ['<C-y>'] = { 'select_and_accept' },

            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },

            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

            ['<Tab>'] = { 'accept', 'fallback' },
            ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

            ['<CR>'] = { 'accept', 'fallback' },
        },

        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono'
        },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
                window = {
                    border = 'rounded',
                },
            },
            menu = {
                border = 'rounded',
                draw = {
                    treesitter = { 'lsp' },
                    columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
                },
            },
            ghost_text = {
                enabled = true,
            },
        },

        signature = {
            enabled = true,
            window = {
                border = 'rounded',
            },
        },
    })
end
