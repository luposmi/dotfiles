-- a git wrapper
local fugitive = {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "open fugitive" })
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
        signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
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
        status_formatter             = nil, -- Use default
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
            map('n', ']c', function()
                if vim.wo.diff then
                    vim.cmd.normal({ ']c', bang = true })
                else
                    gitsigns.nav_hunk('next')
                end
            end)

            map('n', '[c', function()
                if vim.wo.diff then
                    vim.cmd.normal({ '[c', bang = true })
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
        "nvim-lua/plenary.nvim",     -- required
        "sindrets/diffview.nvim",    -- optional - Diff integration
        -- Only one of these is needed.
        "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()

   end
}
return { fugitive, gitsigns, neogit }
