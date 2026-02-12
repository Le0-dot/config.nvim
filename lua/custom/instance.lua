function HostEdit(sock_path, flags, files)
    local initial_tabpage = vim.api.nvim_get_current_tabpage()


    vim.cmd.tabedit(files[1])
    vim.iter(files)
        :skip(1)
        :each(
            vim.list_contains(flags, '-d') and vim.cmd.diffsplit or vim.cmd.vsplit
        )

    local instance_position = vim.api.nvim_tabpage_get_number(0)

    vim.api.nvim_create_autocmd("TabClosed", {
        pattern = tostring(instance_position),
        once = true,
        callback = function()
            if vim.api.nvim_tabpage_is_valid(initial_tabpage) then
                vim.api.nvim_set_current_tabpage(initial_tabpage)
            end

            local sock = vim.fn.sockconnect("pipe", sock_path, { rpc = true })
            vim.fn.rpcnotify(sock, "nvim_command", "quit!")
        end,
    })
end

local sock_path = os.getenv("NVIM")

if not sock_path then
    return
end

local files = vim.fn.argv()
local flags = vim.iter(vim.v.argv):filter(function(arg) return vim.startswith(arg, '-') end):totable()

local rpc_sock = vim.fn.serverlist()[1] or vim.fn.serverstart()

local sock = vim.fn.sockconnect("pipe", sock_path, { rpc = true })
vim.fn.rpcrequest(sock, "nvim_exec_lua", "HostEdit(...)", { rpc_sock, flags, files })

while true do
    vim.wait(10000)
end
