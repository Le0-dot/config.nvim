vim.keymap.set(
    { 'n', 'i', 't' }, '<M-t>', function() vim.cmd([[$tab term]]) end, { desc = 'Open new tab with terminal' }
)

vim.keymap.set(
    { 'n', 'i', 't' }, '<M-g>', function()
        vim.cmd([[$tab term lazygit]])

        -- Try closing when entering another tab
        vim.api.nvim_create_autocmd('TabEnter', {
            callback = function() pcall(vim.cmd.tabclose, '#') end,
            once = true,
        })
    end,
    { desc = 'Open new tab with lazygit' }
)

vim.keymap.set(
    { 'n', 'i', 't' }, '<M-o>', function()
        vim.cmd([[$tab term opencode]])
    end,
    { desc = 'Open new tab with opencode' }
)


vim.api.nvim_create_autocmd('TermOpen', {
    desc = 'Enable Esc and Ctrl + [ to exit terminal mode',
    pattern = 'term://*sh',
    callback = function(args)
        vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { buffer = args.buf })
        vim.keymap.set('t', '<C-[>', '<C-\\><C-n>', { buffer = args.buf })
    end
})

vim.api.nvim_create_autocmd({ 'TermOpen', 'BufEnter' }, {
    desc = 'Hide statusline and cmd when entering a terminal buffer',
    pattern = 'term://*',
    callback = function()
        vim.o.cmdheight = 0
        vim.opt.laststatus = 0
    end
})

vim.api.nvim_create_autocmd('BufLeave', {
    desc = 'Restore statusline when leaving a terminal buffer',
    pattern = 'term://*',
    callback = function() vim.opt.laststatus = 2 end
})

vim.api.nvim_create_autocmd('TermOpen', {
    desc = 'Enter TERMINAL mode when creating a terminal buffer',
    pattern = 'term://*',
    command = 'startinsert',
})

vim.api.nvim_create_autocmd('TermClose', {
    desc = 'Skip the exit code when closing a terminal buffer',
    pattern = 'term://*',
    callback = function(_) vim.api.nvim_input('<CR>') end
})
