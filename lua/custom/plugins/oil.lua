return {
    'stevearc/oil.nvim',
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    lazy = false,
    keys = {
        { "n", "<leader>ed", function() vim.cmd.edit("%:h") end, desc = "[E]dit [d]irectory" },
    },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        default_file_explorer = true,
    },
}
