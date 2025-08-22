return {
    {
        'mfussenegger/nvim-dap',
        keys = { -- TODO: Change keybinds
            {
                '<F5>',
                function()
                    require('dap').continue()
                end,
                desc = 'Debug: Start/Continue',
            },
            {
                '<F1>',
                function()
                    require('dap').step_into()
                end,
                desc = 'Debug: Step Into',
            },
            {
                '<F2>',
                function()
                    require('dap').step_over()
                end,
                desc = 'Debug: Step Over',
            },
            {
                '<F3>',
                function()
                    require('dap').step_out()
                end,
                desc = 'Debug: Step Out',
            },
            {
                '<leader>b',
                function()
                    require('dap').toggle_breakpoint()
                end,
                desc = 'Debug: Toggle Breakpoint',
            },
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        opts = {
            layouts = {
                {
                    elements = {
                        { id = "watches", size = 0.20 },
                        { id = "scopes",  size = 0.50 },
                        { id = "stacks",  size = 0.30 },
                    },
                    position = "right",
                    size = 60,
                },
                {
                    elements = {
                        { id = "repl" },
                    },
                    position = "bottom",
                    size = 15,
                },
            },
        },
        config = function(_, opts)
            local dap = require('dap')
            local dapui = require('dapui')
            dapui.setup(opts)

            dap.listeners.after.event_initialized.dapui_config = dapui.open
            dap.listeners.before.event_terminated.dapui_config = dapui.close
            dap.listeners.before.event_exited.dapui_config = dapui.close

            vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
            vim.fn.sign_define("DapBreakpoint", { text = '', texthl = 'DapBreak' })
        end,
    },
    {
        'mfussenegger/nvim-dap-python',
        dependencies = {
            'mfussenegger/nvim-dap',
        },
        ft = "python",
        config = function(_, _)
            require('dap-python').setup('uv')
        end,
        keys = {
            {
                '<leader>id',
                'Oimport debugpy; debugpy.listen(5678); debugpy.wait_for_client()j:!uv pip install debugpy<CR>',
                desc = 'Debug: Set Breakpoint',
            },
        },
    },
}
