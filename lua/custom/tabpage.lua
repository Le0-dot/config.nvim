-- Bind Alt + n to switch tabs
for i = 1, 9 do
    vim.keymap.set(
        { 'n', 'i', 't' }, '<M-' .. i .. '>', function() pcall(vim.cmd.tabnext, i) end,
        { desc = 'Open ' .. i .. ' tab' }
    )
end

vim.api.nvim_create_autocmd('TabEnter', {
    desc = 'Restore the mode when entering a tab',
    callback = function()
        local success, mode = pcall(vim.api.nvim_tabpage_get_var, 0, 'mode')
        if not success then
            return
        end

        local mode_table = {
            ['n'] = function() vim.cmd.stopinsert() end,
            ['nt'] = function() vim.cmd.stopinsert() end,
            ['i'] = function() vim.cmd.startinsert() end,
            ['t'] = function() vim.cmd.startinsert() end,
        }

        local switch_mode = mode_table[mode]
        if not switch_mode then
            return
        end

        vim.api.nvim_create_autocmd({ 'BufEnter', 'SafeState' }, {
            callback = switch_mode,
            once = true,
        })
    end,
})

vim.api.nvim_create_autocmd('TabLeave', {
    desc = 'Save the mode when leaving a tab',
    callback = function()
        vim.api.nvim_tabpage_set_var(0, 'mode', vim.api.nvim_get_mode().mode)
    end,
})
