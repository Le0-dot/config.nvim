vim.pack.add({
    { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.x') },
})

require('blink.cmp').setup({
    keymap = { preset = 'enter' },
    completion = {
        list = { selection = { preselect = true, } },
        documentation = { auto_show = true, auto_show_delay_ms = 0 },
    },
    -- opts_extend = { "sources.default" }
})
