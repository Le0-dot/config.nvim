vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'

vim.o.ignorecase = true
vim.o.infercase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 0
vim.o.softtabstop = -1
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.autoindent = true

vim.o.updatetime = 250
vim.o.timeoutlen = 500

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.cursorline = true
vim.o.scrolloff = 999

vim.o.undofile = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.autoread = true

vim.o.winborder = 'rounded'
vim.o.showmode = false
vim.o.shortmess = 'oOstTWACFS'

vim.o.showmatch = true
vim.o.inccommand = 'split'

vim.o.diffopt = 'vertical'

vim.o.clipboard = 'unnamedplus'

vim.keymap.set('n', '<C-q>', '<C-w><C-q>', { desc = 'Close focused window' })
vim.keymap.set('n', '<Esc>', vim.cmd.nohlsearch, { desc = 'Stop highlighting the search results' })


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
