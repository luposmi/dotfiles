return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
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
        "neovim/nvim-lspconfig",

    },

    config = function()
        local lsp_zero = require('lsp-zero')

        lsp_zero.on_attach(function(_, bufnr)
            local opts = { buffer = bufnr, remap = false }
            vim.keymap.set("n", "<leader>f",   function() vim.lsp.buf.format()           end, { unpack(opts), desc = "format from lsp"})
            vim.keymap.set("n", "gd",          function() vim.lsp.buf.definition()       end, { unpack(opts), desc = "show information about hover"})
            vim.keymap.set("n", "K",           function() vim.lsp.buf.hover()            end, { unpack(opts), desc = "show information about hover"})
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, { unpack(opts), desc = "search for workspace symbol"})
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action()      end, { unpack(opts), desc = "lsp code action"})
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references()       end, { unpack(opts), desc = "lsp show references"})
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename()           end, { unpack(opts), desc = "lsp rename"})
            vim.keymap.set("i", "<C-h>",       function() vim.lsp.buf.signature_help()   end, { unpack(opts), desc = "lsp get help on signature"})
            vim.keymap.set("n", "<leader>vd",  function() vim.diagnostic.open_float()    end, { unpack(opts), desc = "open diagnostics"})
            vim.keymap.set("n", "[d",          function() vim.diagnostic.goto_prev()     end, { unpack(opts), desc = "go to previous diagnostic"})
            vim.keymap.set("n", "]d",          function() vim.diagnostic.goto_next()     end, { unpack(opts), desc = "go to next diagnostic"})
        end)

        -- to learn how to use mason.nvim with lsp-zero
        -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = { "bashls", "clangd", "lua_ls", "rust_analyzer", "zls"},
            handlers = {
                lsp_zero.default_setup,
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
            }
        })

        require('lspconfig')['hls'].setup{
            filetypes = { 'haskell', 'lhaskell', 'cabal' },
        }

        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        -- this is the function that loads the extra snippets to luasnip
        -- from rafamadriz/friendly-snippets
        require('luasnip.loaders.from_vscode').lazy_load()

        cmp.setup({
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'luasnip', keyword_length = 2 },
                { name = 'buffer',  keyword_length = 3 },
            },
            formatting = lsp_zero.cmp_format(),
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-Enter>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
        })
    end
}
