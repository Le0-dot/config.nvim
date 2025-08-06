return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'kyazdani42/nvim-web-devicons',
    },
    opts = {
        options = { section_separators = '', component_separators = '│' },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff' },
            lualine_c = { { 'filename', path = 1 }, },
            lualine_x = { 'diagnostics', 'filetype' },
            lualine_y = { 'lsp_status' },
            lualine_z = { 'searchcount', 'location' }
        },
    }
}
