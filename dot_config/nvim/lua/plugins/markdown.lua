local renderer = {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        quote = {
            highlight = 'RenderMarkdownBullet'
        },
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
local function addSource(source)
    vim.ui.input({ prompt = "Enter File Name" }, function(input)
        if #input == 0 then
            return
        end
        local client = require("obsidian").get_client()
        -- vim.cmd(string.format("ObsidianNewFromTemplate 1-source_material/%s/%s source.md",source,input))
        local note = client:create_note({
            title = input,
            id = input,
            tags = { source },
            -- TODO: How can i set the id independent of the files name?
            --id = string.format("source-%s-%s",source,input),
            dir = string.format("1-source_material/%s", source),
            no_write = true,
        })
        client:open_note(note, { sync = true })
        client:write_note_to_buffer(note, { template = "source.md" })
    end)
end

local function insert_screenshot_link()
    vim.fn.system("screenshot_area")

    -- Define the screenshot directory
    local screenshot_dir = vim.fn.expand("~/Pictures/Screenshots/")

    -- Get the most recently created screenshot file
    local last_screenshot = vim.fn.systemlist(string.format("ls -t %s | head -n 1", screenshot_dir))[1]
    if not last_screenshot or last_screenshot == "" then
        print("No screenshot found!")
        return
    end

    -- Get the full path of the screenshot
    local screenshot_path = screenshot_dir .. last_screenshot

    -- :p for full path, :h for directory
    local buffer_path = vim.fn.expand("%:p:h")
    --local target_path = buffer_path .. "/assets/" .. last_screenshot
    local assets_dir = buffer_path .. "/assets/"
    vim.fn.mkdir(assets_dir, "p")
    local target_path = assets_dir .. last_screenshot

    -- Copy the screenshot to the current buffer's directory
    print("test")
    local result = vim.fn.system(string.format("cp -p %s %s", vim.fn.shellescape(screenshot_path),
        vim.fn.shellescape(target_path)))
    if vim.v.shell_error ~= 0 then
        print("Error copying screenshot: " .. result)
        return
    end

    -- Replace the line under the cursor with the Markdown image link
    local image_link = string.format("![](assets/%s)", last_screenshot)
    vim.api.nvim_set_current_line(image_link)
end

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
    keys = {
        { "<leader>ot",  "<cmd>ObsidianTags<CR>",                 desc = "obsidian tags" },
        { "<leader>oc",  "<cmd>ObsidianTOC<CR>",                  desc = "obsidian table of content" },
        { "<leader>ob",  "<cmd>ObsidianBacklinks<CR>",            desc = "obsidian backlinks" },
        { "<leader>ob",  "<cmd>ObsidianBacklinks<CR>",            desc = "obsidian backlinks" },
        { "<leader>ot",  "<cmd>ObsidianToday<CR>",                desc = "obsidian today" },
        { "<leader>osy", function() addSource("youtube") end,     desc = "new youtube source" },
        { "<leader>osw", function() addSource("website") end,     desc = "new youtube source" },
        { "<leader>oa",  function() insert_screenshot_link() end, desc = "new youtube source" },
    },

    config = function()
        require("obsidian").setup({
            workspaces = {
                {
                    name = "personal",
                    path = "~/Documents",
                },
            },
            ui = { enable = false },
            follow_url_func = function(url)
                vim.fn.jobstart({ "xdg-open", url })
            end,
            daily_notes = {
                folder = "5_dailies",
                date_format = "%Y-%m-%d",
                -- alias_format
                default_tags = { "daily-note" },
                template = "daily.md"
            },
            templates = {
                folder = "9-templates",
                substitutions = {}
            },

            -- see below for full list of options 👇
        })
    end
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
        vim.keymap.set("n", "<leader>op", "<cmd>MarkdownPreviewToggle<CR>", { desc = "open markdown preview" })
    end
}
local new_preview = {
    "jannis-baum/vivify.vim",
    config = function()
        vim.keymap.set("n", "<leader>op", "<cmd>Vivify<CR>", { desc = "open markdown preview" })
    end

}
return { renderer, obsidian, new_preview }
