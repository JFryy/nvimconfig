return function()
    local lsp_zero = require('lsp-zero')
    lsp_zero.extend_lspconfig()
    lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
        local opts = { buffer = bufnr }
        vim.keymap.set({ 'n', 'x' }, 'gq', function()
            vim.lsp.buf.format({ async = true, timeout_ms = 5000 })
        end, opts)
    end)

    require('mason-lspconfig').setup({
        ensure_installed = {
            'bashls',
            'gopls',
            'lua_ls'
        }
    })

end
