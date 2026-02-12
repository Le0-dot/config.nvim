for i = 1, 9 do
    vim.keymap.set(
        { 'n', 'i', 't' }, '<M-' .. i .. '>', function() pcall(vim.cmd.tabnext, i) end,
        { desc = 'Open ' .. i .. ' tab' }
    )
end

vim.api.nvim_create_autocmd('TabEnter', {
    desc = 'Restore the mode when entering a tab',
    callback = function()
        local mode_table = {
            ['n'] = 'stopinsert',
            ['nt'] = 'stopinsert',
            ['i'] = 'startinsert',
            ['t'] = 'startinsert',
        }

        vim.api.nvim_create_autocmd({ 'BufEnter', 'SafeState' }, {
            command = mode_table[vim.t.mode] or '',
            once = true,
        })
    end,
})

vim.api.nvim_create_autocmd('TabLeave', {
    desc = 'Save the mode when leaving a tab',
    callback = function()
        vim.t.mode = vim.api.nvim_get_mode().mode
    end,
})
