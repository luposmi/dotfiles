return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
        require('telescope').setup {
            extensions = {
                fzf = {
                    fuzzy = true,     -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                }
            }
        }
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {desc = 'Telescope find files'})
        vim.keymap.set('n', '<leader>pg', builtin.git_files, {desc = 'Telescope git files'})
        vim.keymap.set('n', '<leader>ps', builtin.live_grep, {desc = 'Telescope live grep'})
        vim.keymap.set('n', '<leader>pb', builtin.buffers, {desc = 'Telescope buffer'})
        vim.keymap.set('n', '<leader>ph', builtin.help_tags, {desc = 'Telescope help tags'})
        vim.keymap.set('n', '<leader>pt', builtin.treesitter, {desc = 'Telescope treesitter'})
        vim.keymap.set('n', '<leader>pk', builtin.keymaps, {desc = 'Telescope keymaps'})
        vim.keymap.set('n', '<leader>pw', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end, {desc = 'Telescope grep WORD under cursor'})
        vim.keymap.set('n', '<leader>vs',
            function() require('telescope.builtin').lsp_document_symbols({ symbols = { 'function', 'method' } }) end,
            { desc = "list all methods in file" })
        -- LSP Keybindings
        vim.keymap.set('n', '<leader>vo', builtin.lsp_outgoing_calls, {desc = 'Telescope LSP outgoing calls'})
        vim.keymap.set('n', '<leader>vi', builtin.lsp_incoming_calls, {desc = 'Telescope LSP incoming calls'})
        require('telescope').load_extension('fzf')
    end
}
