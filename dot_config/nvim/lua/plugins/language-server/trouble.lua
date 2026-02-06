-- shows LSP diagnostics
return {
    "folke/trouble.nvim",
    require = "nvim-telescope/telescope.nvim",
    config = function()
        local actions = require("telescope.actions")
        local open_with_trouble = require("trouble.sources.telescope").open

        -- Use this to add more results without clearing the trouble list
        local add_to_trouble = require("trouble.sources.telescope").add

        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                mappings = {
                    i = { ["<c-T>"] = open_with_trouble },
                    n = { ["<c-T>"] = open_with_trouble },
                },
            },
        })
    end,
    cmd = "Trouble",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>cs",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>cl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
}
