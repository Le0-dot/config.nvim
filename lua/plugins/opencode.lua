return {
    "sudo-tee/opencode.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MeanderingProgrammer/render-markdown.nvim",
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
