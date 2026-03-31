-- Map leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- Line number
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'


-- Search
vim.o.ignorecase = true
vim.o.infercase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true


-- Indenting
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 0
vim.o.softtabstop = -1
vim.o.smarttab = true

vim.o.smartindent = true
vim.o.autoindent = true

-- Timing
vim.o.updatetime = 250
vim.o.timeoutlen = 500


-- Splits
vim.o.splitright = true
vim.o.splitbelow = true


-- Cursor
vim.o.cursorline = true
vim.o.scrolloff = 999


-- Filesystem
vim.o.undofile = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false


-- Misc
vim.o.showmode = false
vim.o.showmatch = true
vim.o.inccommand = 'split'
vim.o.shortmess = 'oOstTWACFS'
vim.o.autoread = true


vim.o.winborder = 'rounded'

vim.o.diffopt = 'vertical'

-- System clipboard interactions
vim.keymap.set({ 'n', 'x' }, 'gy', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', 'gp', '"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set('n', 'gP', '"+P', { desc = 'Paste from system clipboard' })
vim.keymap.set('v', 'gp', '"+P', { desc = 'Paste from system clipboard in visual mode' })


-- Some custom general keymaps
vim.keymap.set('n', '<C-q>', '<C-w><C-q>', { desc = 'Close focused window' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Stop highlighting the search results' })

vim.keymap.set(
    'n',
    'gyf',
    function() vim.fn.setreg("+", vim.fn.expand("%:.")) end,
    { desc = 'Copy relative file path to system clipboard' }
)
vim.keymap.set(
    'n',
    'gyd',
    function() vim.fn.setreg("+", vim.fn.expand("%:.:h")) end,
    { desc = 'Copy relative file path to system clipboard' }
)

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Hightlight selection on yank',
    callback = function()
        vim.hl.on_yank({ higroup = 'DiffText', timeout = 500 })
    end,
})
--
-- vim.api.nvim_create_autocmd({ "CursorMoved" }, {
--     desc = 'Center buffer after cursor is moved',
--     callback = function() vim.cmd("normal! zz") end,
-- })


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

vim.keymap.set('x', 'gsd', ':SelectionDiff<CR>', { desc = 'Call SelectionDiff' })


function Dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. Dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end
