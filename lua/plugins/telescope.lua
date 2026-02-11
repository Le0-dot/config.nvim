local builtin = require('telescope.builtin')

return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
    },
    event = 'VeryLazy',
    keys = {
        { '<leader>sh',       builtin.help_tags,   desc = '[S]earch [H]elp' },
        { '<leader>sk',       builtin.keymaps,     desc = '[S]earch [K]eymaps' },
        { '<leader>sf',       builtin.find_files,  desc = '[S]earch [F]iles' },
        { '<leader>ss',       builtin.builtin,     desc = '[S]earch [S]elect Telescope' },
        { '<leader>sw',       builtin.grep_string, desc = '[S]earch current [W]ord' },
        { '<leader>sg',       builtin.live_grep,   desc = '[S]earch by [G]rep' },
        { '<leader>sd',       builtin.diagnostics, desc = '[S]earch [D]iagnostics' },
        { '<leader>sr',       builtin.resume,      desc = '[S]earch [R]esume' },
        { '<leader><leader>', builtin.buffers,     desc = '[ ] Find existing buffers' },
        {
            '<leader>su',
            function()
                builtin.lsp_references {
                    include_declaration = false,
                }
            end,
            desc = '[S]earch [U]sage'
        },
        {
            '<leader>st',
            function()
                builtin.live_grep {
                    type_filter = vim.fn.expand('%:e'),
                    prompt_title = 'Live Grep in ' .. vim.bo.filetype .. ' files'
                }
            end,
            desc = '[S]earch in Files of specific [T]ype'
        },
    },
    config = function()
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
    end
}
