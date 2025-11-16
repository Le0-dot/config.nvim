function HostEdit(sock_path, file)
    local term_bufnr = vim.api.nvim_get_current_buf()

    vim.cmd.edit(file)
    local edit_bufnr = vim.api.nvim_get_current_buf()

    vim.api.nvim_create_autocmd("BufWritePost", {
        buffer = edit_bufnr,
        callback = function()
            vim.api.nvim_set_current_buf(term_bufnr)
            vim.cmd.startinsert()

            vim.api.nvim_buf_delete(edit_bufnr, {})

            local sock = vim.fn.sockconnect("pipe", sock_path, { rpc = true })
            vim.fn.rpcnotify(sock, "nvim_command", "quit!")
        end,
    })
end

local sock_path = os.getenv("NVIM")

if not sock_path then
    return
end

local rpc_sock = vim.fn.serverlist()[1] or vim.fn.serverstart()
local files = vim.fn.argv()

local sock = vim.fn.sockconnect("pipe", sock_path, { rpc = true })
vim.fn.rpcrequest(sock, "nvim_exec_lua", "HostEdit(...)", { rpc_sock, files[1] })

while true do
    vim.wait(10000)
end
