-- vim.diagnostic.config({ virtual_lines = { current_line = true } })
vim.diagnostic.config({ float = { scope = 'cursor' } })

-- vim.api.nvim_create_autocmd('CursorHold', {
--     desc = 'Show diagnostic window for current line',
--     callback = function() vim.diagnostic.open_float() end,
-- })
