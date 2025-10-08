return {
    {
        'mfussenegger/nvim-dap',
        config = function()
            vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
            vim.fn.sign_define("DapBreakpoint", { text = '', texthl = 'DapBreak' })

            local dap = require("dap")
            dap.adapters.python = function(cb, config)
                if config.request == 'attach' then
                    local adapter = {
                        type = 'server',
                        port = config.connect.port,
                        host = config.connect.host,
                        options = {
                            source_filetype = 'python',
                        }
                    }
                    cb(adapter)
                end
            end

            dap.configurations = {
                python = {
                    {
                        type = 'python',
                        request = 'attach',
                        name = 'attach',
                        justMyCode = false,
                        connect = function()
                            local host = '127.0.0.1'
                            local port = 5678
                            return { host = host, port = port }
                        end,
                    }
                }
            }
        end

    },
    {
        'miroshQa/debugmaster.nvim',
        dependencies = { 'mfussenegger/nvim-dap' },
        config = function()
            vim.keymap.set('n', '<leader>d', require('debugmaster').mode.toggle, { nowait = true })
        end,
    },
}
