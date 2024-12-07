local renderer = {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        checkbox = {
            enabled = true,
            position = 'inline',
            unchecked = {
                icon = '󰄱 ',
                highlight = 'RenderMarkdownUnchecked',
                scope_highlight = nil,
            },
            checked = {
                icon = '󰱒 ',
                highlight = 'RenderMarkdownChecked',
                scope_highlight = nil,
            },
            custom = {
                todo = { raw = '[-]', rendered = '', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
                rightarrow = { raw = '[>]', rendered = '󰧛' , highlight = 'RenderMarkdownRightArrow', scope_highlight = nil },
                tilde = { raw = '[~]', rendered = '󰰱', highlight = 'RenderMarkdownTilde', scope_highlight = nil },
                important = { raw = '[!]', rendered = '', highlight = 'RenderMarkdownImportant', scope_highlight = nil },
            },
        },
    }
}
local obsidian = {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",

        -- see below for full list of optional dependencies 👇
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/Documents",
            },
        },
        ui = { enable = false }

        -- see below for full list of options 👇
    },
}

local preview = {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
    end,
    config = function()
        vim.keymap.set("n","<leader>op","<cmd>MarkdownPreviewToggle", { desc = "open markdown preview"})
    end
}
return { renderer, obsidian, preview }
