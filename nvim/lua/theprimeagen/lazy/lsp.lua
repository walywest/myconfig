return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "clangd",
                --"rust_analyzer",
                -- "typescript"
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                -- ["basedpyright"] = function()
                --     local lspconfig = require("lspconfig")
                --     lspconfig.basedpyright.setup {
                --         capabilities = capabilities,
                --         settings = {
                --             basedpyright = {
                --                 -- Disable type checking diagnostics
                --                 -- disableTypeChecking = true,
                --
                --                 -- OR be more selective:
                --                 diagnosticMode = "workspace", -- fewer errors than "openFilesOnly"
                --                 typeCheckingMode = "basic",   -- less strict than "strict"
                --
                --                 -- OR suppress specific diagnostics
                --                 disableDiagnosticCodes = {
                --                     "reportUnknownVariableType",
                --                     "reportUnknownMemberType",
                --                 },
                --                 analysis = {
                --                     autoSearchPaths = true,
                --                     useLibraryCodeForTypes = true,
                --                     diagnosticMode = "workspace",
                --                 }
                --             }
                --         }
                --     }
                -- end,
                --
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<tab>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                -- { name = "copilot",   group_index = 2 },
                { name = 'nvim_lsp', group_index = 2 },
                { name = 'luasnip',  group_index = 2 }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            }),
            -- sorting = {
            --     priority_weight = 2,
            --     comparators = {
            --         require("copilot_cmp.comparators").prioritize,
            --
            --         -- Below is the default comparitor list and order for nvim-cmp
            --         cmp.config.compare.offset,
            --         -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            --         cmp.config.compare.exact,
            --         cmp.config.compare.score,
            --         cmp.config.compare.recently_used,
            --         cmp.config.compare.locality,
            --         cmp.config.compare.kind,
            --         cmp.config.compare.sort_text,
            --         cmp.config.compare.length,
            --         cmp.config.compare.order,
            --     },
            -- },

        })

        vim.diagnostic.config({

            --//NOTE: tbh idk why added those too
            update_in_insert = true,
            virtual_text = true,

            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
