-- Map leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- Line number
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'


-- System clipboard interactions
vim.keymap.set({ 'n', 'x' }, 'gy', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', 'gp', '"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set('n', 'gP', '"+P', { desc = 'Paste from system clipboard' })
vim.keymap.set('v', 'gp', '"+P', { desc = 'Paste from system clipboard in visual mode without copying' })


-- Search
vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true


-- Indenting
vim.opt.expandtab = true -- Tabs with spaces
vim.opt.tabstop = 4      -- Width of tab character
vim.opt.shiftwidth = 0   -- Width of tabs for > and < (0 to use tabstop value)
vim.opt.softtabstop = -1 -- Number of spaces to insert for <TAB> and delete for <BS> (negative to use shiftwidth value)
vim.opt.smarttab = true

vim.opt.smartindent = true
vim.opt.autoindent = true


-- Timing
vim.opt.updatetime = 250 -- Timeout for plugin start
vim.opt.timeoutlen = 500 -- Mapping timeout


-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true


-- Cursor
vim.opt.cursorline = true -- Highlight current line
vim.opt.scrolloff = 10


-- Filesystem
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.o.swapfile = false


-- Misc
vim.opt.showmode = false -- Show Insert, Visial or Replace mode
vim.opt.showmatch = true
vim.opt.formatoptions:remove('o')
vim.opt.inccommand = 'split'  -- Show preview in a split
vim.opt.shortmess:append('S') -- Don't show search count in right corner

-- Diagnostics
vim.diagnostic.config({ virtual_lines = { current_line = true } })

-- Border
vim.o.winborder = 'rounded'


-- Remove trailing spaces and trailing empty lines
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        pcall(function() vim.cmd [[%s/\s\+$//e]] end)   -- Delete trailing white spaces
        pcall(function() vim.cmd [[%s/\n\+\%$//e]] end) -- Delete trailing empty lines
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Center buffer after move
vim.api.nvim_create_autocmd({ "CursorMoved" }, {
    callback = function() vim.cmd("normal! zz") end,
})


-- Some custom general keymaps
vim.keymap.set('n', '<leader>x', ':.lua<cr>', { desc = 'Execute current lua line' })
vim.keymap.set('v', '<leader>x', ':lua<cr>', { desc = 'Execute selected lua lines' })

vim.keymap.set('n', '<C-q>', '<C-w><C-q>', { desc = 'Close focused window' })

vim.keymap.set({ 'n', 'x' }, '<leader>d', '"_d', { desc = 'Delete without overriding current registers' })
vim.keymap.set('n', '<leader>D', '"_D', { desc = 'Delete without overriding current registers' })
vim.keymap.set('x', '<leader>p', '"_dP"', { desc = 'Paste without copying' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Stop highlighting the search results' })

vim.keymap.set('n', 'gyf', ':let @+ = expand("%:~:.")<CR>', { desc = 'Copy relative file path to system clipboard' })

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

-- TODO: Auto enable all configured lsp
vim.lsp.enable('lua-language-server')
vim.lsp.enable('ruff')
vim.lsp.enable('basedpyright')
vim.lsp.enable('robotcode')
vim.lsp.enable('nil')
vim.lsp.enable('hls')

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function()
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
        -- TODO: Auto format
        vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end)
    end
})
