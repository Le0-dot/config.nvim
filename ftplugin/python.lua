local dap = require("dap")
local port = 5678
local host = "127.0.0.1"

local function buf_start_toggle(lines, present)
    local buf = 0
    local len = #lines

    local actual = vim.api.nvim_buf_get_lines(buf, 0, len, false)
    local equals = vim.deep_equal(lines, actual)

    if not equals and present then
        vim.api.nvim_buf_set_lines(buf, 0, 0, false, lines)
    elseif equals and not present then
        vim.api.nvim_buf_set_lines(buf, 0, len, false, {})
    end
end

vim.api.nvim_create_autocmd("User", {
    pattern = "DebugModeChanged",
    callback = function(args)
        local lines = {
            '# fmt: off',
            'import debugpy',
            'debugpy.listen(' .. port .. ')',
            'debugpy.wait_for_client()',
            '# fmt: on',
        }
        buf_start_toggle(lines, args.data.enabled)
        vim.cmd.write()
    end
})

dap.adapters.python = function(callback, config)
    local adapter
    if config.request == 'attach' then
        adapter = {
            type = 'server',
            port = config.connect.port,
            host = config.connect.host,
            options = {
                source_filetype = 'python',
            }
        }
    end
    callback(adapter)
end

dap.configurations.python = {
    {
        type = 'python',
        request = 'attach',
        name = 'attach',
        justMyCode = false,
        connect = function()
            return { host = host, port = port }
        end,
    }
}
