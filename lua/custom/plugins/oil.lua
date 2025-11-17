return {
    'stevearc/oil.nvim',
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    lazy = false,
    keys = {
        { "<leader>ed", function() vim.cmd.edit("%:h") end, desc = "[E]dit [d]irectory" },
    },
    opts = {
        default_file_explorer = true,
        buf_options = {
            buflisted = false,
            bufhidden = "hide",
        },
        delete_to_trash = true,
        view_options = {
            show_hidden = true,
        },
    },
}
