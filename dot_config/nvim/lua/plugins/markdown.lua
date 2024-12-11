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
                rightarrow = { raw = '[>]', rendered = '󰧛', highlight = 'RenderMarkdownRightArrow', scope_highlight = nil },
                tilde = { raw = '[~]', rendered = '󰰱', highlight = 'RenderMarkdownTilde', scope_highlight = nil },
                important = { raw = '[!]', rendered = '', highlight = 'RenderMarkdownImportant', scope_highlight = nil },
            },
        },
        callout = {
            note = { raw = '[!NOTE]', rendered = '󰋽 Note ', highlight = 'RenderMarkdownInfo' },
            tip = { raw = '[!TIP]', rendered = '󰌶 Tip ', highlight = 'RenderMarkdownSuccess' },
            definition = { raw = '[!DEF]', rendered = '󰌶 Definition', highlight = 'RenderMarkdownInfo' },
            important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important ', highlight = 'RenderMarkdownHint' },
            warning = { raw = '[!WARNING]', rendered = '󰀪 Warning ', highlight = 'RenderMarkdownWarn' },
            caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution ', highlight = 'RenderMarkdownError' },
            -- Obsidian: https://help.obsidian.md/Editing+and+formatting/Callouts
            abstract = { raw = '[!ABSTRACT]', rendered = '󰨸 Abstract ', highlight = 'RenderMarkdownInfo' },
            summary = { raw = '[!SUMMARY]', rendered = '󰨸 Summary ', highlight = 'RenderMarkdownInfo' },
            tldr = { raw = '[!TLDR]', rendered = '󰨸 Tldr ', highlight = 'RenderMarkdownInfo' },
            info = { raw = '[!INFO]', rendered = '󰋽 Info ', highlight = 'RenderMarkdownInfo' },
            todo = { raw = '[!TODO]', rendered = '󰗡 Todo ', highlight = 'RenderMarkdownInfo' },
            hint = { raw = '[!HINT]', rendered = '󰌶 Hint ', highlight = 'RenderMarkdownSuccess' },
            success = { raw = '[!SUCCESS]', rendered = '󰄬 Success ', highlight = 'RenderMarkdownSuccess' },
            check = { raw = '[!CHECK]', rendered = '󰄬 Check ', highlight = 'RenderMarkdownSuccess' },
            done = { raw = '[!DONE]', rendered = '󰄬 Done ', highlight = 'RenderMarkdownSuccess' },
            question = { raw = '[!QUESTION]', rendered = '󰘥 Question ', highlight = 'RenderMarkdownWarn' },
            help = { raw = '[!HELP]', rendered = '󰘥 Help ', highlight = 'RenderMarkdownWarn' },
            faq = { raw = '[!FAQ]', rendered = '󰘥 Faq ', highlight = 'RenderMarkdownWarn' },
            attention = { raw = '[!ATTENTION]', rendered = '󰀪 Attention ', highlight = 'RenderMarkdownWarn' },
            failure = { raw = '[!FAILURE]', rendered = '󰅖 Failure ', highlight = 'RenderMarkdownError' },
            fail = { raw = '[!FAIL]', rendered = '󰅖 Fail ', highlight = 'RenderMarkdownError' },
            missing = { raw = '[!MISSING]', rendered = '󰅖 Missing ', highlight = 'RenderMarkdownError' },
            danger = { raw = '[!DANGER]', rendered = '󱐌 Danger ', highlight = 'RenderMarkdownError' },
            error = { raw = '[!ERROR]', rendered = '󱐌 Error ', highlight = 'RenderMarkdownError' },
            bug = { raw = '[!BUG]', rendered = '󰨰 Bug ', highlight = 'RenderMarkdownError' },
            example = { raw = '[!EXAMPLE]', rendered = '󰉹 Example ', highlight = 'RenderMarkdownHint' },
            quote = { raw = '[!QUOTE]', rendered = '󱆨 Quote ', highlight = 'RenderMarkdownQuote' },
            cite = { raw = '[!CITE]', rendered = '󱆨 Cite ', highlight = 'RenderMarkdownQuote' },
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
        ui = { enable = false },
        follow_url_func = function(url)
            vim.fn.jobstart({"xdg-open", url})
        end

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
