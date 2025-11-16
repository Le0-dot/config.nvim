-- Common application shortcuts
vim.keymap.set(
    { 'n', 'i', 't' }, '<M-t>', function() vim.cmd([[$tab term]]) end, { desc = 'Open new terminal tab with shell' }
)

vim.keymap.set(
    { 'n', 'i', 't' }, '<M-g>', function() vim.cmd([[$tab term lazygit]]) end,
    { desc = 'Open new terminal tab with lazygit' }
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
