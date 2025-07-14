return {
    {
        'mfussenegger/nvim-dap',
        keys = {
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
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')
            dapui.setup()

            dap.listeners.after.event_initialized.dapui_config = dapui.open
            dap.listeners.before.event_terminated.dapui_config = dapui.close
            dap.listeners.before.event_exited.dapui_config = dapui.close

            vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
            vim.fn.sign_define("DapBreakpoint", { text = '', texthl = 'DapBreak' })
        end,
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = {
            'mason-org/mason.nvim',
            'mfussenegger/nvim-dap',
        },
        opts = {
            automatic_installation = false,
            handlers = {},
            ensure_installed = {
                "debugpy",
            },
        },
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
                'Oimport debugpy; debugpy.listen(5678); debugpy.wait_for_client()j',
                desc = 'Debug: Set Breakpoint',
            },
        },
    },
}
