function HostEdit(sock_path, flags, files)
    local variables = vim.fn.getcompletion('t:', 'var')
    local values = vim.iter(variables)
        :map(function(variable) return variable:sub(#'t:' + 1) end)
        :map(function(variable) return { variable = variable, value = vim.api.nvim_tabpage_get_var(0, variable) } end)
        :totable()

    local buffer = vim.api.nvim_get_current_buf()
    vim.bo[buffer].bufhidden = 'hide'

    local edit = files[1] and vim.cmd.edit or vim.cmd.enew
    local split = vim.list_contains(flags, '-d') and vim.cmd.diffsplit or vim.cmd.vsplit

    edit(files[1])
    vim.iter(files):skip(1):each(split)

    vim.iter(vim.api.nvim_tabpage_list_wins(0))
        :map(vim.api.nvim_win_get_buf)
        :each(function(buf) vim.bo[buf].bufhidden = 'wipe' end)

    vim.o.eventignore = 'TabLeave' -- Suppress autoclosing of tabpages

    vim.api.nvim_create_autocmd("TabClosed", {
        pattern = tostring(vim.api.nvim_tabpage_get_number(0)),
        once = true,
        callback = function()
            vim.o.eventignore = 'BufEnter' -- Suppress autocmds for empty scratch buffer

            vim.cmd.tabnew()
            vim.iter(values):each(function(pair) vim.api.nvim_tabpage_set_var(0, pair.variable, pair.value) end)

            vim.o.eventignore = ''

            vim.api.nvim_set_current_buf(buffer)
            vim.bo[buffer].bufhidden = ''

            local sock = vim.fn.sockconnect("pipe", sock_path, { rpc = true })
            vim.fn.rpcnotify(sock, "nvim_command", "quit!")
        end,
    })
end

local sock_path = os.getenv("NVIM")

if not sock_path then
    return
end

local files = vim.iter(vim.fn.argv())
    :map(vim.fs.abspath)
    :totable()
local flags = vim.iter(vim.v.argv)
    :filter(function(arg) return vim.startswith(arg, '-') end)
    :totable()

local rpc_sock = vim.fn.serverlist()[1] or vim.fn.serverstart()

local sock = vim.fn.sockconnect("pipe", sock_path, { rpc = true })
vim.fn.rpcrequest(sock, "nvim_exec_lua", "HostEdit(...)", { rpc_sock, flags, files })

while true do
    vim.wait(10000)
end
