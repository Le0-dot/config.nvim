return {
    'gbprod/yanky.nvim',
    opts = {
        system_clipboard = {
            sync_with_ring = false,
        },
    },
    keys = {
        { "y", "<Plug>(YankyYank)",            mode = { "n", "x" }, },
        { "p", "<Plug>(YankyPutIndentAfter)",  mode = { "n", "x" }, },
        { "P", "<Plug>(YankyPutIndentBefore)", mode = { "n", "x" }, },
    },
}
