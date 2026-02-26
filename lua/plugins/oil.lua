return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
        { "<leader>ed", vim.cmd.Oil, desc = "[E]dit [d]irectory" },
    },
    opts = {
        default_file_explorer = true,
        buf_options = {
            buflisted = false,
            bufhidden = 'wipe',
        },
        delete_to_trash = true,
        view_options = {
            show_hidden = true,
        },
    },
}
