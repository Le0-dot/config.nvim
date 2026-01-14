return {
    "sudo-tee/opencode.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "MeanderingProgrammer/render-markdown.nvim",
            opts = {
                anti_conceal = { enabled = false },
                file_types = { 'markdown', 'opencode_output' },
            },
            ft = { 'markdown', 'Avante', 'copilot-chat', 'opencode_output' },
        },
        'nvim-telescope/telescope.nvim',
        'saghen/blink.cmp',
    },
    opts = {
        ui = {
            window_width = 0.5,
            display_cost = false,
        },
    },
}
