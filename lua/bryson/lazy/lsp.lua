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
        "j-hui/fidget.nvim",
        "L3MON4D3/LuaSnip",
    },

    config = function()
        local lspconfig = require("lspconfig")
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")

        local capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        mason.setup()
        mason_lspconfig.setup({
            ensure_installed = {
                "rust_analyzer",
                "pyright",
                "lua_ls",
                "html",
                "ts_ls"
            },

            handlers = {
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                    })
                end,

                ["eslint"] = function()
                    lspconfig.eslint.setup({
                        capabilities = capabilities,
                        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "html" },
                    })
                end,
            }


        })

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                -- { name = 'supermaven' },
                { name = 'copilot' },
                { name = 'buffer' },
                { name = 'luasnip' },
            })
        })


        vim.diagnostic.config({
            update_in_insert = true,
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
