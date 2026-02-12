vim.api.nvim_create_user_command("WithSession", function(data)
    local path = #data.fargs > 0 and data.fargs[1] or vim.fn.getcwd()
    local file = #data.fargs > 1 and data.fargs[2] or "Session.vim"

    vim.cmd.cd(path)

    if vim.fn.filereadable(file) == 0 then
        vim.cmd.mksession(file)
    end

    vim.cmd.source(file)

    vim.api.nvim_create_autocmd("VimLeavePre", { command = "mksession! " .. file })
end, { desc = "Open neovim with session in specified directory", nargs = "*" })
