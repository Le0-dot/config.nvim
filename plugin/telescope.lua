vim.pack.add({
    { src = 'https://github.com/nvim-telescope/telescope.nvim' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },
})

require('telescope').setup({
    defaults = {
        layout_config = {
            horizontal = {
                prompt_position = 'top',
                height = { padding = 0 },
                width = { padding = 0 },
            },
        },
        sorting_strategy = 'ascending',
    },
})
require('telescope').load_extension('ui-select')

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>sh',       builtin.help_tags,   {desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk',       builtin.keymaps,     {desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf',       builtin.find_files,  {desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss',       builtin.builtin,     {desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw',       builtin.grep_string, {desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg',       builtin.live_grep,   {desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd',       builtin.diagnostics, {desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr',       builtin.resume,      {desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers,     {desc = '[ ] Find existing buffers' })
vim.keymap.set('n',
    '<leader>su',
    function()
        builtin.lsp_references {
            include_declaration = false,
        }
    end,
    { desc = '[S]earch [U]sage' })
vim.keymap.set('n', 
    '<leader>st',
    function()
        builtin.live_grep {
            type_filter = vim.fn.expand('%:e'),
            prompt_title = 'Live Grep in ' .. vim.bo.filetype .. ' files'
        }
    end,
    {
    desc = '[S]earch in Files of specific [T]ype'
})
