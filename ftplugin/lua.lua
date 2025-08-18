vim.keymap.set('n', '<leader>x', ':.lua<cr>', { desc = 'Execute current lua line' })
vim.keymap.set('v', '<leader>x', ':lua<cr>', { desc = 'Execute selected lua lines' })
vim.keymap.set('n', '<leader><leader>x', ':%lua<cr>', { desc = 'Execute current lua file' })
