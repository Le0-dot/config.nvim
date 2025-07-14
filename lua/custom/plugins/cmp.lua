return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        {
            'L3MON4D3/LuaSnip',
            build = "make install_jsregexp",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
            keys = {
                {
                    "<C-f>",
                    function()
                        require('luasnip').jump(1)
                    end,
                    silent = true,
                    mode = { "i", "s" },

                },
                {
                    "<C-b>",
                    function()
                        require('luasnip').jump(-1)
                    end,
                    silent = true,
                    mode = { "i", "s" },

                },
            },
        },
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
    },
    config = function()
        local cmp = require('cmp')

        vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

        cmp.setup {
            snippet = {
                expand = function(args) require('luasnip').lsp_expand(args.body) end
            },
            mapping = cmp.mapping.preset.insert({
                ['<Tab>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                ['<S-Tab>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
            }),
            sources = {
                { name = 'nvim_lsp', keyword_length = 1 },
                { name = 'buffer',   keyword_length = 1 },
                { name = 'luasnip',  keyword_length = 1 },
                { name = 'path' },
            },
            window = {
                documentation = cmp.config.window.bordered()
            },
            sorting = {
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.exact,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
        }
    end,
}
