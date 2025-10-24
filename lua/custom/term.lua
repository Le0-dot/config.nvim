-- Make Ctrl + [ and Esc work in term window
vim.keymap.set(
    't', '<C-[>', '<C-\\><C-n>', { desc = 'Open new tab with terminal' }
)
vim.keymap.set(
    't', '<Esc>', '<C-\\><C-n>', { desc = 'Open new tab with terminal' }
)

-- Common application shortcuts
vim.keymap.set(
    { 'n', 'i', 't' }, '<M-t>', function() vim.cmd([[$tab term]]) end, { desc = 'Open new tab with terminal' }
)

vim.keymap.set(
    { 'n', 'i', 't' }, '<M-g>', function() vim.cmd([[tab term lazygit]]) end, { desc = 'Open new tab with terminal' }
)

-- Bind Alt + n to switch tabs
for i = 1, 9 do
    vim.keymap.set(
        { 'n', 'i', 't' }, '<M-' .. i .. '>', function() pcall(vim.cmd, 'tabnext ' .. i) end,
        { desc = 'Open new tab with terminal' }
    )
end

-- Enter TERMINAL mode on entering term window
vim.api.nvim_create_autocmd('TermOpen', { command = 'startinsert' })
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = 'term://*',
    command = 'startinsert',
})

vim.api.nvim_create_autocmd('TermOpen', {
    pattern = 'term://*lazygit',
    callback = function(args)
        vim.keymap.set('t', '<C-[>', 'q', { buffer = args.buf, desc = 'Quit lazygit with Esc sequence' })
        vim.keymap.set('t', '<Esc>', 'q', { buffer = args.buf, desc = 'Quit lazygit with Esc' })
    end,
})
vim.api.nvim_create_autocmd('TermClose', {
    pattern = 'term://*lazygit',
    callback = function(_) vim.api.nvim_input('<CR>') end
})
