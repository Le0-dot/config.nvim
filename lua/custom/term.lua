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
        { 'n', 'i', 't' }, '<M-' .. i .. '>', function() vim.cmd('tabnext ' .. i) end,
        { desc = 'Open new tab with terminal' }
    )
end

-- Enter TERMINAL mode on entering term window
vim.api.nvim_create_autocmd('TermOpen', { command = 'startinsert' })
vim.api.nvim_create_autocmd('WinEnter', {
    callback = function(args)
        if vim.startswith(args.file, "term://") then
            vim.cmd([[startinsert]])
        end
    end
})
