return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local lspconfig = require('lspconfig')
        local cmp_lsp = require("cmp_nvim_lsp")
        
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                local opts = { buffer = ev.buf, remap = false }
                
                vim.keymap.set("n", "<leader>f",  function() vim.lsp.buf.format() end, { buffer = ev.buf, desc = "format from lsp" })
                vim.keymap.set("n", "gd",         function() vim.lsp.buf.definition() end, { buffer = ev.buf, desc = "go to definition" })
                vim.keymap.set("n", "K",          function() vim.lsp.buf.hover() end, { buffer = ev.buf, desc = "hover information" })
                vim.keymap.set("n", "<leader>vw", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vc", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>",       function() vim.lsp.buf.signature_help() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d",         function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "]d",         function() vim.diagnostic.goto_next() end, opts)
            end,
        })

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = { "bashls", "clangd", "lua_ls", "rust_analyzer", "zls", "verible" },
            handlers = {
                -- Default handler for installed servers
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                    })
                end,

                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = { globals = { "vim" } }
                            }
                        }
                    })
                end,

                ["verible"] = function()
                    lspconfig.verible.setup({
                        capabilities = capabilities,
                        cmd = { vim.fn.stdpath("data") .. "/mason/bin/verible-verilog-ls" },
                        filetypes = { "verilog", "systemverilog" },
                        root_dir = lspconfig.util.root_pattern(".git", "verible.config", "compile_commands.json"),
                    })
                end,
            }
        })

        lspconfig.hls.setup({
            capabilities = capabilities,
            filetypes = { 'haskell', 'lhaskell', 'cabal' },
        })

        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        require('luasnip.loaders.from_vscode').lazy_load()
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-Enter>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip', keyword_length = 2 },
                { name = 'path' },
            }, {
                { name = 'buffer', keyword_length = 3 },
            })
        })
    end
}
