return {
    'stevearc/oil.nvim',
    dependencies = { "echasnovski/mini.nvim" },
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            keymaps = {
                ["ga"] = { "ddGp''", desc = "move the file/ directory under cursor to the bottom"},
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
                ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
                ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
            use_default_keymaps = false,
        })
        previewer_config = require("telescope.previewers").new_buffer_previewer({
            define_preview = function(self, entry, status)
                local lines = {}
                local ls_command = io.popen("ls \"" .. entry.value .. "\"")
                for line in ls_command:lines() do 
                   table.insert(lines,line)
                end
                ls_command:close()
                vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, true, lines)
            end
        })
        local conf = require("telescope.config").values
        local function getDirectories()
            local directories = {}
            local find_command = io.popen("find . -type d ! -path '*/.*'")
            for dir in find_command:lines() do
                table.insert(directories, dir)
            end
            find_command:close()
            require("telescope.pickers").new({}, {
                prompt_title = "Oil",
                finder = require("telescope.finders").new_table({
                    results = directories,
                }),
                previewer = previewer_config,
                sorter = conf.generic_sorter({}),
            }):find()
        end
        vim.keymap.set("n", "<leader>po", getDirectories);

        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
}
