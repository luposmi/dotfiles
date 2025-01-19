-- a git wrapper
local fugitive = {
    "tpope/vim-fugitive",
    config = function()
    end
}
local gitsigns = {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs                        = {
            add          = { text = '+' },
            change       = { text = '┃' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signs_staged                 = {
            add          = { text = '+' },
            change       = { text = '┃' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signs_staged_enable          = true,
        signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
            follow_files = true
        },
        auto_attach                  = true,
        attach_to_untracked          = false,
        current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
            virt_text_priority = 100,
            use_focus = true,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil,   -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
            -- Options passed to nvim_open_win
            border = 'single',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },
        on_attach                    = function(bufnr)
            local gitsigns = require('gitsigns')

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']h', function()
                if vim.wo.diff then
                    vim.cmd.normal({ ']h', bang = true })
                else
                    gitsigns.nav_hunk('next')
                end
            end)

            map('n', '[h', function()
                if vim.wo.diff then
                    vim.cmd.normal({ '[h', bang = true })
                else
                    gitsigns.nav_hunk('prev')
                end
            end)

            -- Actions
            map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "gitsigns stage hung" })
            map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = "gitsigns unstage hunk" })
            map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "gitsigns reset hunk" })
            map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                { desc = "gitsigns stage" })
            map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                { desc = "gitsigns reset" })
            map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "gitsigns stage buffer" })
            map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "gitsigns reset buffer" })
            map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "gitsigns preview hunk" })
            map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = "gitsigns blame full" })
            map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "gitsigns current line blame" })
            map('n', '<leader>hd', gitsigns.diffthis, { desc = "gitsigns diff this" })
            map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = "gitsigns diff this" })
            map('n', '<leader>htd', gitsigns.toggle_deleted, { desc = "gitsigns toggle delete" })

            -- Text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
    }
}
local neogit = {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",         -- required
        "sindrets/diffview.nvim",        -- optional - Diff integration
        -- Only one of these is needed.
        "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
        local neogit_rq = require('neogit')
        neogit_rq.setup {}
        vim.keymap.set("n", "<leader>gs", neogit_rq.open, { desc = "open neogit" })

        vim.keymap.set("n", "<leader>gA", function() neogit_rq.open({ "cherry_pick" }) end, { desc = "git cherry_pick" })
        vim.keymap.set("n", "<leader>gb", function() neogit_rq.open({ "branch" }) end, { desc = "git branch" })
        vim.keymap.set("n", "<leader>gB", function() neogit_rq.open({ "bisect" }) end, { desc = "git bisect" })
        vim.keymap.set("n", "<leader>gc", function() neogit_rq.open({ "commit" }) end, { desc = "create commit" })
        vim.keymap.set("n", "<leader>gd", function() neogit_rq.open({ "diff" }) end, { desc = "git diff" })
        vim.keymap.set("n", "<leader>gf", function() neogit_rq.open({ "fetch" }) end, { desc = "git fetch" })
        vim.keymap.set("n", "<leader>gI", function() neogit_rq.open({ "init" }) end, { desc = "git init" })
        vim.keymap.set("n", "<leader>gi", function() neogit_rq.open({ "ignore" }) end, { desc = "git ignore" })
        vim.keymap.set("n", "<leader>gl", function() neogit_rq.open({ "log" }) end, { desc = "git log" })
        vim.keymap.set("n", "<leader>gm", function() neogit_rq.open({ "merge" }) end, { desc = "git merge" })
        vim.keymap.set("n", "<leader>gpl", function() neogit_rq.open({ "pull" }) end, { desc = "git pull" })
        vim.keymap.set("n", "<leader>gps", function() neogit_rq.open({ "push" }) end, { desc = "git push" })
        vim.keymap.set("n", "<leader>gr", function() neogit_rq.open({ "rebase" }) end, { desc = "git rebase" })
        vim.keymap.set("n", "<leader>gR", function() neogit_rq.open({ "remote" }) end, { desc = "git remote" })
        vim.keymap.set("n", "<leader>gt", function() neogit_rq.open({ "tag" }) end, { desc = "git tag" })
        vim.keymap.set("n", "<leader>gv", function() neogit_rq.open({ "revert" }) end, { desc = "git revert" })
        vim.keymap.set("n", "<leader>gw", function() neogit_rq.open({ "worktree" }) end, { desc = "git worktree" })
        vim.keymap.set("n", "<leader>gX", function() neogit_rq.open({ "reset" }) end, { desc = "git reset" })
        vim.keymap.set("n", "<leader>gZ", function() neogit_rq.open({ "stash" }) end, { desc = "git stash" })
    end
}

return { fugitive, gitsigns, neogit }
