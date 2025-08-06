return {
    'saghen/blink.cmp',
    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = 'enter' },
        completion = {
            list = { selection = { preselect = true, } },
            documentation = { auto_show = true, auto_show_delay_ms = 0 },
        },
    },
    opts_extend = { "sources.default" }
}
