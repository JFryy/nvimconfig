return function()
    local lsp_zero = require('lsp-zero')
    lsp_zero.extend_cmp()
    local cmp = require('cmp')
    local cmp_action = lsp_zero.cmp_action()

    cmp.setup({
        formatting = lsp_zero.cmp_format(),
        mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-j>'] = cmp.mapping.scroll_docs(-4),
            ['<C-k>'] = cmp.mapping.scroll_docs(4),
            ['<C-f>'] = cmp_action.luasnip_jump_forward(),
            ['<C-b>'] = cmp_action.luasnip_jump_backward(),
            ['<tab>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
        }),
        experimental = {
            ghost_text = true
        }
    })
end 