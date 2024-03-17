
local function telescope_viewer(harpoon_files, telescope)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = telescope.file_previewer({}),
        sorter = telescope.generic_sorter({}),
    }):find()
end

local function set_keymaps(harpoon)
    local telescope = require("telescope.config").values;
    vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
    vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    vim.keymap.set("n", "<C-e>", function() telescope_viewer(harpoon:list(),telescope) end, { desc = "Open harpoon window" })
end


return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup({})
        set_keymaps(harpoon)
    end
}
