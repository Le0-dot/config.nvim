-- Common application shortcuts
vim.keymap.set(
    { 'n', 'i', 't' }, '<M-t>', function() vim.cmd([[$tab term]]) end, { desc = 'Open new terminal tab with shell' }
)

vim.keymap.set(
    { 'n', 'i', 't' }, '<M-g>', function()
        vim.cmd([[$tab term lazygit]])
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_create_autocmd('BufLeave',
            {
                buffer = buf,
                callback = function(args) vim.api.nvim_buf_delete(args.buf, { force = true }) end,
            }
        )

        -- Works for some reason
        vim.o.cmdheight = 0
    end,
    { desc = 'Open new terminal tab with lazygit' }
)

vim.keymap.set(
    { 'n', 'i', 't' }, '<M-o>', function()
        vim.cmd([[$tab term opencode]])
        -- Works for some reason
        vim.o.cmdheight = 0
    end,
    { desc = 'Open new terminal tab with opencode' }
)

-- Bind Alt + n to switch tabs
for i = 1, 9 do
    vim.keymap.set(
        { 'n', 'i', 't' }, '<M-' .. i .. '>', function() pcall(vim.cmd.tabnext, i) end,
        { desc = 'Open ' .. i .. ' tab' }
    )
end

-- Make Ctrl + [ and Esc work in term window
vim.api.nvim_create_autocmd('TermOpen', {
    pattern = 'term://*sh',
    callback = function(args)
        vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { buffer = args.buf })
        vim.keymap.set('t', '<C-[>', '<C-\\><C-n>', { buffer = args.buf })
    end
})

-- Enter TERMINAL mode on entering term window
vim.api.nvim_create_autocmd('TermOpen', { command = 'startinsert' })
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = 'term://*',
    command = 'startinsert',
})

-- Skip the exit code
vim.api.nvim_create_autocmd('TermClose', {
    pattern = 'term://*',
    callback = function(_) vim.api.nvim_input('<CR>') end
})
