---@type vim.lsp.Config
return {
    settings = {
        ["nu"] = {
            cmd = { "nu" , "--lsp" },
            filetypes = { "nu" },
        }
    },
}
