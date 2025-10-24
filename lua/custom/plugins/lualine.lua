local function location_with_char_count()
    local mode = vim.fn.mode()

    if mode == 'v' then
        return string.format("%d", vim.fn.wordcount().visual_chars)
    elseif mode == 'V' then
        local cursor = vim.fn.getpos(".")
        local other = vim.fn.getpos("v")
        return string.format("%d", vim.fn.abs(cursor[2] - other[2]) + 1)
    elseif mode == '' then
        local cursor = vim.fn.getpos(".")
        local other = vim.fn.getpos("v")
        return string.format("%d:%d", vim.fn.abs(cursor[2] - other[2]) + 1, vim.fn.abs(cursor[3] - other[3]) + 1)
    else
        return string.format("%d:%d", vim.fn.line('.'), vim.fn.charcol('.'))
    end
end

local function dir_name()
    local cwd = vim.fn.getcwd()
    local dir = vim.fn.fnamemodify(cwd, ":t")
    return dir
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
            tabline = {
                lualine_a = { { 'tabs', mode = 2, path = 4 }, },
                lualine_z = { dir_name },
            },
        })
    end
}
