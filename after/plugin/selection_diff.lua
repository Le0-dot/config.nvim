vim.api.nvim_create_user_command('SelectionDiff', function()
    local selection_start = vim.fn.getpos("'<")
    local selection_end = vim.fn.getpos("'>")
    local text = vim.api.nvim_buf_get_text(0,
        selection_start[2] - 1, -- start row (0-based)
        selection_start[3] - 1, -- start col (0-based)
        selection_end[2] - 1,   -- end row (0-based)
        selection_end[3],       -- end col (0-based, exclusive, so no -1 needed)
        {}
    )

    local new_buf = vim.api.nvim_create_buf(false, true)
    vim.bo[new_buf].bufhidden = 'wipe'

    vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, text)

    local original_win = vim.api.nvim_get_current_win()

    vim.cmd.vsplit()
    vim.api.nvim_win_set_buf(0, new_buf)

    vim.cmd.diffthis()

    vim.api.nvim_set_current_win(original_win)
end, { desc = 'Create new diff window with selected text', range = true })

vim.keymap.set('x', '<leader>sd', ':SelectionDiff<CR>', { desc = 'Call SelectionDiff' })
