vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.core",
    callback = function()
        vim.bo.filetype = "yaml"
    end,
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*zshrc",
    callback = function()
        vim.bo.filetype = "zsh"
    end,
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.kdl",
    callback = function ()
        vim.bo.filetype = "kdl"
        vim.cmd("TSBufEnable highlight");
    end
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.conf.tmpl",
    callback = function ()
        vim.bo.filetype = "conf"
    end
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.md",
    callback = function ()
        -- vim.cmd("colorscheme rose-pine")
    end
})
