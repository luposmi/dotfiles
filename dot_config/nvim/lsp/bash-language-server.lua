---@type vim.lsp.Config
return {
    settings = {
        ["bashls"] = {
            cmd = { "bash-language-server", "start" },
            filetypes = { "zsh", "sh", "bash" },
        }
    },
}
