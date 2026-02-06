return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        build = "make install_jsregexp",
        opts = {
            keep_roots = true,
            link_roots = true,
            link_children = true
        },
        dependencies = { "rafamadriz/friendly-snippets" },
    }
}
