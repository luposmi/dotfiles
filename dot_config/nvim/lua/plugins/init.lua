return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
    end,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
    }
}
