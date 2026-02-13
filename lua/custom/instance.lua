function HostEdit(sock_path, flags, files)
    local buffer = vim.api.nvim_get_current_buf()
    vim.bo[buffer].bufhidden = 'hide'

    local edit = files[1] and vim.cmd.edit or vim.cmd.enew
    local split = vim.list_contains(flags, '-d') and vim.cmd.diffsplit or vim.cmd.vsplit

    edit(files[1])
    vim.iter(files):skip(1):each(split)

    vim.iter(vim.api.nvim_tabpage_list_wins(0))
        :map(vim.api.nvim_win_get_buf)
        :each(function(buf) vim.bo[buf].bufhidden = 'wipe' end)

    vim.o.eventignore = 'TabLeave'

    vim.api.nvim_create_autocmd("TabClosed", {
        pattern = tostring(vim.api.nvim_tabpage_get_number(0)),
        once = true,
        callback = function()
            vim.cmd.tabnew()
            vim.cmd.buffer(buffer)
            vim.cmd.startinsert()

            vim.bo[buffer].bufhidden = ''
            vim.o.eventignore = ''

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
local flags = vim.iter(vim.v.argv)
    :filter(function(arg) return vim.startswith(arg, '-') end)
    :totable()

local rpc_sock = vim.fn.serverlist()[1] or vim.fn.serverstart()

local sock = vim.fn.sockconnect("pipe", sock_path, { rpc = true })
vim.fn.rpcrequest(sock, "nvim_exec_lua", "HostEdit(...)", { rpc_sock, flags, files })

while true do
    vim.wait(10000)
end
