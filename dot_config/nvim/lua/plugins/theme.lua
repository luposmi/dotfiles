local rose_pine = {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
        require("rose-pine").setup({
            variant = "auto",      -- auto, main, moon, or dawn
            dark_variant = "main", -- main, moon, or dawn
            dim_inactive_windows = false,
            extend_background_behind_borders = true,

            enable = {
                terminal = true,
                legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
                migrations = true,        -- Handle deprecated options automatically
            },

            styles = {
                bold = true,
                italic = true,
                transparency = true,
            },

            groups = {
                border = "muted",
                link = "iris",
                panel = "surface",

                error = "love",
                hint = "iris",
                info = "foam",
                note = "pine",
                todo = "rose",
                warn = "gold",

                git_add = "foam",
                git_change = "rose",
                git_delete = "love",
                git_dirty = "rose",
                git_ignore = "muted",
                git_merge = "iris",
                git_rename = "pine",
                git_stage = "iris",
                git_text = "rose",
                git_untracked = "subtle",

                h1 = "iris",
                h2 = "foam",
                h3 = "rose",
                h4 = "gold",
                h5 = "pine",
                h6 = "foam",
            },

            highlight_groups = {
                -- Comment = { fg = "foam" },
                -- VertSplit = { fg = "muted", bg = "muted" },
            },

            before_highlight = function(group, highlight, palette)
                -- Disable all undercurls
                -- if highlight.undercurl then
                --     highlight.undercurl = false
                -- end
                --
                -- Change palette colour
                -- if highlight.fg == palette.pine then
                --     highlight.fg = palette.foam
                -- end
            end,
        })

        -- vim.cmd("colorscheme rose-pine")
        -- vim.cmd("colorscheme rose-pine-main")
        -- vim.cmd("colorscheme rose-pine-moon")
        -- vim.cmd("colorscheme rose-pine-dawn")
    end
}

local kangawa = {
    "rebelot/kanagawa.nvim",
    config = function()
        require("kanagawa").setup({ transparent = true })
        vim.cmd("colorscheme kanagawa")
    end
}
local catppuccin = {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
        highlight_overrides = {
            all = function(colors)
                return {
                    CurSearch = { bg = colors.sky },
                    IncSearch = { bg = colors.sky },
                    CursorLineNr = { fg = colors.blue, style = { "bold" } },
                    DashboardFooter = { fg = colors.overlay0 },
                    TreesitterContextBottom = { style = {} },
                    WinSeparator = { fg = colors.overlay0, style = { "bold" } },
                    ["@markup.italic"] = { fg = colors.blue, style = { "italic" } },
                    ["@markup.strong"] = { fg = colors.blue, style = { "bold" } },
                    Headline = { style = { "bold" } },
                }
            end,
        },
        color_overrides = {
            macchiato = {
--[[                rosewater = "#F5B8AB",
                flamingo = "#F29D9D",
                pink = "#AD6FF7",
                mauve = "#FF8F40",
                red = "#E66767",
                maroon = "#EB788B",
                peach = "#FAB770",
                yellow = "#FACA64",
                green = "#70CF67",
                teal = "#4CD4BD",
                sky = "#61BDFF",
                sapphire = "#4BA8FA",
                blue = "#00BFFF",
                lavender = "#00BBCC",
                text = "#C1C9E6", ]]--
                rosewater = "#f4dbd6",
                flamingo = "#f0c6c6",
                pink = "#f5bde6",
                mauve = "#c6a0f6",
                red = "#ed8796",
                maroon = "#ee99a0",
                peach = "#f5a97f",
                yellow = "#eed49f",
                green = "#a6da95",
                teal = "#8bd5ca",
                sky = "#91d7e3",
                sapphire = "#7dc4e4",
                blue = "#8aadf4",
                lavender = "#b7bdf8",
                text = "#cad3f5",
                subtext1 = "#A3AAC2",
                subtext0 = "#8E94AB",
                overlay2 = "#7D8296",
                overlay1 = "#676B80",
                overlay0 = "#464957",
                surface2 = "#3A3D4A",
                surface1 = "#2F313D",
                surface0 = "#1D1E29",
                base = "#070710",
                mantle = "#11111a",
                crust = "#191926",
            },
        },
        integrations = {
            telescope = {
                enabled = true,
                style = "nvchad",
            },
        },
    }
}

return { kangawa, rose_pine, catppuccin }
