return {
    'echasnovski/mini.nvim',
    config = function()
        require('mini.extra').setup()
        require('mini.sessions').setup()
        require('mini.surround').setup()

        local ai = require('mini.ai')
        ai.setup {
            custom_textobjects = {
                F = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
                c = ai.gen_spec.treesitter { a = '@conditional.outer', i = '@conditional.inner' },
            }
        }

        local hipatterns = require('mini.hipatterns')
        hipatterns.setup({
            highlighters = {
                -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
                fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
                todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
                note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

                -- Highlight hex color strings (`#rrggbb`) using that color
                hex_color = hipatterns.gen_highlighter.hex_color(),
            },
        })
    end,
}
