local servers = {
    lua_ls = {
        single_file_support = true,
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                format = {
                    enable = true,
                    defaultConfig = {
                        indent_style = "space",
                        indent_size = "2",
                    }
                },
                workspace = {
                    checkThirdParty = false,
                    -- Tells lua_ls where to find all the Lua files that you have loaded
                    -- for your neovim configuration.
                    library = {
                        '${3rd}/luv/library',
                        unpack(vim.api.nvim_get_runtime_file('', true)),
                    },
                },
                diagnostics = {
                    globals = { 'vim' },
                },
            },
        },
    },
    -- clangd = {},
    -- hls = {
    --     filetypes = { 'haskell', 'lhaskell', 'cabal' },
    -- },
    basedpyright = {},
    robotframework_ls = {},
}

return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'hrsh7th/cmp-nvim-lsp',
                dependecies = { 'hrsh7th/nvim-cmp', },
            },
            'j-hui/fidget.nvim',
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('custom-lsp-attach', { clear = false }),
                callback = function(event)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                    vim.keymap.set('n', 'grf', function() vim.lsp.buf.format { async = true } end, bufopts)
                end
            })

            -- TODO: https://github.com/nvim-lua/kickstart.nvim/blob/3338d3920620861f8313a2745fd5d2be39f39534/init.lua#L594

            Capabilities = vim.tbl_deep_extend('force',
                vim.lsp.protocol.make_client_capabilities(),
                require('cmp_nvim_lsp').default_capabilities()
            )

            local lspconfig = require('lspconfig')
            lspconfig.util.default_config = vim.tbl_deep_extend('force',
                lspconfig.util.default_config,
                {
                    capabilities = capabilities,
                }
            )
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = {},
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        dependencies = {
            'williamboman/mason.nvim',
        },
        opts = {
            ensure_installed = vim.tbl_keys(servers),
            auto_update = true,
        },
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            'neovim/nvim-lspconfig',
        },
        opts = {
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    require('lspconfig')[server_name].setup {
                        cmd = server.cmd,
                        settings = server.settings,
                        filetypes = server.filetypes,
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for tsserver)
                        capabilities = vim.tbl_deep_extend('force', Capabilities, server.capabilities or {}),
                    }
                end,
            },
        }
    },
    {
        'j-hui/fidget.nvim',
        opts = {},
    },
}
