local function location_with_char_count()
    local line = vim.fn.line(".")
    local col = vim.fn.charcol(".")

    if vim.fn.mode():find("[vV]") then
        return string.format("%d:%d:%d", line, col, vim.fn.wordcount().visual_chars)
    else
        return string.format("%d:%d", line, col)
    end
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'kyazdani42/nvim-web-devicons',
    },
    config = function()
        local dmode_enabled = false
        vim.api.nvim_create_autocmd("User", {
            pattern = "DebugModeChanged",
            callback = function(args)
                dmode_enabled = args.data.enabled
            end
        })
        require('lualine').setup({
            options = { section_separators = '', component_separators = '│' },
            sections = {
                lualine_a = {
                    {
                        'mode',
                        cond = function() return not dmode_enabled end,
                    },
                    {
                        '"DEBUG"',
                        cond = function()
                            return dmode_enabled
                        end
                    }
                },
                lualine_b = { 'branch', 'diff' },
                lualine_c = { { 'filename', path = 1 }, },
                lualine_x = { 'filetype' },
                lualine_y = { 'diagnostics', 'lsp_status' },
                lualine_z = { 'searchcount', location_with_char_count }
            },
        })
    end
}
