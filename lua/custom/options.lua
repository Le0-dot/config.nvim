-- Map leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- Line number
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'


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
vim.keymap.set(
    'n',
    '<leader>ed',
    function() vim.cmd([[e %:h]]) end,
    { desc = 'Edit directory of currently opened file' }
)

require('custom.term')

vim.lsp.enable(
    vim.iter(vim.api.nvim_get_runtime_file('lsp/*.lua', true))
    :map(function(f) return vim.fn.fnamemodify(f, ':t:r') end)
    :totable()
)

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd('BufWritePre', {
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end
})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Hightlight selection on yank',
    callback = function()
        vim.highlight.on_yank({ higroup = 'DiffText', timeout = 500 })
    end,
})

vim.api.nvim_create_autocmd({ "CursorMoved" }, {
    desc = 'Center buffer after cursor is moved',
    callback = function() vim.cmd("normal! zz") end,
})


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
