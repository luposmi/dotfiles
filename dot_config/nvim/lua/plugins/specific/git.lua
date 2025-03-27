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
        neogit_rq.setup {
            -- Hides the hints at the top of the status buffer
            disable_hint = false,
            -- Disables changing the buffer highlights based on where the cursor is.
            disable_context_highlighting = true,
            -- Disables signs for sections/items/hunks
            disable_signs = false,
            -- Changes what mode the Commit Editor starts in. `true` will leave nvim in normal mode, `false` will change nvim to
            -- insert mode, and `"auto"` will change nvim to insert mode IF the commit message is empty, otherwise leaving it in
            -- normal mode.
            disable_insert_on_commit = "auto",
            -- When enabled, will watch the `.git/` directory for changes and refresh the status buffer in response to filesystem
            -- events.
            filewatcher = {
                interval = 1000,
                enabled = true,
            },
            -- "ascii"   is the graph the git CLI generates
            -- "unicode" is the graph like https://github.com/rbong/vim-flog
            -- "kitty"   is the graph like https://github.com/isakbm/gitgraph.nvim - use https://github.com/rbong/flog-symbols if you don't use Kitty
            graph_style = "unicode",
            -- Show relative date by default. When set, use `strftime` to display dates
            commit_date_format = nil,
            log_date_format = nil,
            -- Used to generate URL's for branch popup action "pull request".
            git_services = {
                ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
                ["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
                ["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
                ["azure.com"] = "https://dev.azure.com/${owner}/_git/${repository}/pullrequestcreate?sourceRef=${branch_name}&targetRef=${target}",
            },
            -- Allows a different telescope sorter. Defaults to 'fuzzy_with_index_bias'. The example below will use the native fzf
            -- sorter instead. By default, this function returns `nil`.
            telescope_sorter = nil,
            -- Persist the values of switches/options within and across sessions
            remember_settings = true,
            -- Scope persisted settings on a per-project basis
            use_per_project_settings = true,
            -- Table of settings to never persist. Uses format "Filetype--cli-value"
            ignored_settings = {
                "NeogitPushPopup--force-with-lease",
                "NeogitPushPopup--force",
                "NeogitPullPopup--rebase",
                "NeogitCommitPopup--allow-empty",
                "NeogitRevertPopup--no-edit",
            },
            -- Configure highlight group features
            highlight = {
                italic = true,
                bold = true,
                underline = true
            },
            -- Set to false if you want to be responsible for creating _ALL_ keymappings
            use_default_keymaps = true,
            -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
            -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
            auto_refresh = true,
            -- Value used for `--sort` option for `git branch` command
            -- By default, branches will be sorted by commit date descending
            -- Flag description: https://git-scm.com/docs/git-branch#Documentation/git-branch.txt---sortltkeygt
            -- Sorting keys: https://git-scm.com/docs/git-for-each-ref#_options
            sort_branches = "-committerdate",
            -- Default for new branch name prompts
            initial_branch_name = "",
            -- Change the default way of opening neogit
            kind = "tab",
            -- Disable line numbers
            disable_line_numbers = false,
            -- Disable relative line numbers
            disable_relative_line_numbers = false,
            -- The time after which an output console is shown for slow running commands
            console_timeout = 2000,
            -- Automatically show console if a command takes more than console_timeout milliseconds
            auto_show_console = true,
            -- Automatically close the console if the process exits with a 0 (success) status
            auto_close_console = true,
            notification_icon = "󰊢",
            status = {
                show_head_commit_hash = true,
                recent_commit_count = 10,
                HEAD_padding = 10,
                HEAD_folded = false,
                mode_padding = 3,
                mode_text = {
                    M = "modified",
                    N = "new file",
                    A = "added",
                    D = "deleted",
                    C = "copied",
                    U = "updated",
                    R = "renamed",
                    DD = "unmerged",
                    AU = "unmerged",
                    UD = "unmerged",
                    UA = "unmerged",
                    DU = "unmerged",
                    AA = "unmerged",
                    UU = "unmerged",
                    ["?"] = "",
                },
            },
            commit_editor = {
                kind = "tab",
                show_staged_diff = true,
                -- Accepted values:
                -- "split" to show the staged diff below the commit editor
                -- "vsplit" to show it to the right
                -- "split_above" Like :top split
                -- "vsplit_left" like :vsplit, but open to the left
                -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
                staged_diff_split_kind = "auto",
                spell_check = true,
            },
            commit_select_view = {
                kind = "tab",
            },
            commit_view = {
                kind = "vsplit",
                verify_commit = vim.fn.executable("gpg") == 1, -- Can be set to true or false, otherwise we try to find the binary
            },
            log_view = {
                kind = "tab",
            },
            rebase_editor = {
                kind = "auto",
            },
            reflog_view = {
                kind = "tab",
            },
            merge_editor = {
                kind = "auto",
            },
            description_editor = {
                kind = "auto",
            },
            tag_editor = {
                kind = "auto",
            },
            preview_buffer = {
                kind = "floating_console",
            },
            popup = {
                kind = "split",
            },
            stash = {
                kind = "tab",
            },
            refs_view = {
                kind = "tab",
            },
            signs = {
                -- { CLOSED, OPENED }
                hunk = { "", "" },
                item = { ">", "v" },
                section = { ">", "v" },
            },
            -- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
            integrations = {
                -- If enabled, use telescope for menu selection rather than vim.ui.select.
                -- Allows multi-select and some things that vim.ui.select doesn't.
                telescope = true,
                -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `diffview`.
                -- The diffview integration enables the diff popup.
                --
                -- Requires you to have `sindrets/diffview.nvim` installed.
                diffview = nil,

                -- If enabled, uses fzf-lua for menu selection. If the telescope integration
                -- is also selected then telescope is used instead
                -- Requires you to have `ibhagwan/fzf-lua` installed.
                fzf_lua = nil,

                -- If enabled, uses mini.pick for menu selection. If the telescope integration
                -- is also selected then telescope is used instead
                -- Requires you to have `echasnovski/mini.pick` installed.
                mini_pick = nil,
            },
            sections = {
                -- Reverting/Cherry Picking
                sequencer = {
                    folded = false,
                    hidden = false,
                },
                untracked = {
                    folded = false,
                    hidden = false,
                },
                unstaged = {
                    folded = false,
                    hidden = false,
                },
                staged = {
                    folded = false,
                    hidden = false,
                },
                stashes = {
                    folded = true,
                    hidden = false,
                },
                unpulled_upstream = {
                    folded = true,
                    hidden = false,
                },
                unmerged_upstream = {
                    folded = false,
                    hidden = false,
                },
                unpulled_pushRemote = {
                    folded = true,
                    hidden = false,
                },
                unmerged_pushRemote = {
                    folded = false,
                    hidden = false,
                },
                recent = {
                    folded = true,
                    hidden = false,
                },
                rebase = {
                    folded = true,
                    hidden = false,
                },
            },
        }

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
