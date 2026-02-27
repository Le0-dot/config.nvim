vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = args.buf })

        local client = vim.lsp.get_client_by_id(args.data.client_id)

        vim.api.nvim_create_autocmd('BufWritePre', {
            callback = function()
                if client and client:supports_method("textDocument/formatting") then
                    vim.lsp.buf.format({ async = false })
                end

                vim.lsp.buf.code_action({ context = { diagnostics = {}, only = { "source.organizeImports" }, }, apply = true })
                vim.lsp.buf.code_action({ context = { diagnostics = {}, only = { "source.fixAll" }, }, apply = true })

                vim.wait(30)
            end,
            buffer = args.buf,
        })
    end
})

vim.lsp.enable(
    vim.iter(vim.api.nvim_get_runtime_file('lsp/*.lua', true))
    :map(function(f) return vim.fn.fnamemodify(f, ':t:r') end)
    :totable()
)
