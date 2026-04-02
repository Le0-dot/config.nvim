vim.pack.add({
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

require("oil").setup({
    default_file_explorer = true,
    buf_options = {
        buflisted = false,
        bufhidden = 'wipe',
    },
    delete_to_trash = true,
    view_options = {
        show_hidden = true,
    },
    keymaps = {
        ["gyf"] = {
            mode = 'n',
            callback = function()
                local cwd = vim.fn.getcwd()
                local dir = require("oil").get_current_dir(0)
                local file = require("oil").get_cursor_entry().name
                local relative = vim.fs.relpath(cwd, vim.fs.joinpath(dir, file))
                vim.fn.setreg("", relative)
                vim.fn.setreg("+", relative)
            end
        },
        ["gyd"] = {
            mode = 'n',
            callback = function()
                local cwd = vim.fn.getcwd()
                local dir = require("oil").get_current_dir(0)
                local relative = vim.fs.relpath(cwd, dir)
                vim.fn.setreg("", relative)
                vim.fn.setreg("+", relative)
            end
        },
    },
})

vim.keymap.set('n', "<leader>ed", vim.cmd.Oil, { desc = "[E]dit [d]irectory" })
