return function()
    local lspconfig = require('lspconfig')
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts) -- note: this can be pretty useful
            vim.keymap.set('n', '<leader>f', function()
                vim.lsp.buf.format { async = true }
            end, opts)
            vim.keymap.set({ 'n', 'x' }, 'gq', function()
                vim.lsp.buf.format({ async = true, timeout_ms = 5000 })
            end, opts)
        end,
    })

    require('mason-lspconfig').setup({
        ensure_installed = {
            'bashls',
            'gopls',
            'lua_ls',
            'yamlls',
            'helm_ls',
            'gopls',
        },
        handlers = {
            function(server_name)
                lspconfig[server_name].setup({})
            end,
            ['helm_ls'] = function()
                lspconfig.helm_ls.setup({
                    cmd = { "helm_ls", "serve" },
                    filetypes = { "helm", "helmfile", "yaml.helm", "yaml.helm-values" },
                    settings = {
                        ['helm-ls'] = {
                            yamlls = {
                                enabled = true,
                                enabledForFilesGlob = "*.{yaml,yml,tpl}",
                            },
                        },
                    },
                    capabilities = {
                        workspace = {
                            didChangeWatchedFiles = {
                                dynamicRegistration = true,
                            },
                        },
                    },
                })
            end,
        }
    })
end
