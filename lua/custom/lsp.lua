vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = args.buf })

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd('BufWritePre', {
                callback = function() vim.lsp.buf.format({ async = false }) end,
                buffer = args.buf,
            })
        end
    end
})

vim.lsp.enable(
    vim.iter(vim.api.nvim_get_runtime_file('lsp/*.lua', true))
    :map(function(f) return vim.fn.fnamemodify(f, ':t:r') end)
    :totable()
)
