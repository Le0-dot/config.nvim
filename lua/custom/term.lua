vim.keymap.set({ 'n', 'i', 't' }, '<M-t>', function() vim.cmd([[$tab term]]) end, { desc = 'Open new tab with terminal' })
vim.keymap.set({ 'n', 'i', 't' }, '<M-o>', function() vim.cmd([[$tab term opencode]]) end,
    { desc = 'Open new tab with opencode' })
vim.keymap.set({ 'n', 'i', 't' }, '<M-g>', function() vim.cmd([[$tab term lazygit]]) end,
    { desc = 'Open new tab with lazygit' })

vim.api.nvim_create_autocmd('TabLeave', {
    pattern = 'term://*lazygit',
    callback = function()
        vim.api.nvim_create_autocmd('TabEnter', {
            once = true,
            callback = function() pcall(vim.cmd.tabclose, '#') end,
        })
    end,
})

vim.api.nvim_create_autocmd('TermOpen', {
    desc = 'Enable Esc and Ctrl + [ to exit terminal mode',
    pattern = 'term://*sh',
    callback = function()
        vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { buffer = true })
        vim.keymap.set('t', '<C-[>', '<C-\\><C-n>', { buffer = true })
    end
})

vim.api.nvim_create_autocmd({ 'TermOpen', 'BufEnter' }, {
    desc = 'Hide statusline and cmd when entering a terminal buffer',
    pattern = 'term://*',
    callback = function()
        vim.o.cmdheight = 0
        vim.o.laststatus = 0
    end,
})

vim.api.nvim_create_autocmd('BufLeave', {
    desc = 'Restore statusline when leaving a terminal buffer',
    pattern = 'term://*',
    callback = function()
        vim.o.cmdheight = 1
        vim.o.laststatus = 2
    end
})

vim.api.nvim_create_autocmd('TermOpen', {
    desc = 'Enter TERMINAL mode when creating a terminal buffer',
    pattern = 'term://*',
    command = 'startinsert',
})

vim.api.nvim_create_autocmd('TermClose', {
    desc = 'Skip the exit code when closing a terminal buffer',
    pattern = 'term://*',
    callback = function() vim.api.nvim_input('<CR>') end
})
