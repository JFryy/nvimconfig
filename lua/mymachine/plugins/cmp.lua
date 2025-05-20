return function()
    local lsp_zero = require('lsp-zero')
    lsp_zero.extend_cmp()
    local cmp = require('cmp')
    local cmp_action = lsp_zero.cmp_action()
    local luasnip = require('luasnip')

    cmp.setup({
        formatting = {
            format = function(entry, vim_item)
                -- Kind icons
                vim_item.kind = string.format('%s %s', require('lspkind').presets.default[vim_item.kind], vim_item.kind)
                -- Source
                vim_item.menu = ({
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    luasnip = "[Snippet]",
                    nvim_lua = "[Lua]",
                    latex_symbols = "[LaTeX]",
                })[entry.source.name]
                return vim_item
            end,
        },
        mapping = cmp.mapping.preset.insert({
            -- Enter key to confirm completion
            ['<CR>'] = cmp.mapping.confirm({ select = true }),

            -- Tab key to trigger completion and navigate
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),

            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),

            -- Other mappings
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-j>'] = cmp.mapping.scroll_docs(-4),
            ['<C-k>'] = cmp.mapping.scroll_docs(4),
            ['<C-f>'] = cmp_action.luasnip_jump_forward(),
            ['<C-b>'] = cmp_action.luasnip_jump_backward(),
            ['<C-e>'] = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'path' },
            { name = 'nvim_lua' },
        }),
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        experimental = {
            ghost_text = true,
            native_menu = false,
        },
        performance = {
            max_view_entries = 50,
        },
    })

    -- Set configuration for specific filetypes
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            { name = 'git' },
            { name = 'buffer' },
        })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore)
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore)
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })
end
