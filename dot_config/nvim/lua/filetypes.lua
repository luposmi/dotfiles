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
