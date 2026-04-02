vim.api.nvim_create_user_command("WithSession", function(data)
    if vim.fn.filereadable(data.args) == 0 then
        vim.cmd.cd(vim.fs.dirname(data.args))
        vim.cmd.mksession(data.args)
    end

    vim.cmd.source(data.args)
end, { desc = "Load or create session in specified path", nargs = 1 })

vim.api.nvim_create_autocmd("SessionLoadPost", {
    desc = "Schedule session write on exit",
    callback = function()
        vim.api.nvim_create_autocmd("VimLeavePre", {
            desc = 'Write session on exit',
            command = 'mksession! ' .. vim.v.this_session,
        })
    end,
})
