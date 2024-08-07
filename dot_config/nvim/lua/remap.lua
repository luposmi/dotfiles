vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves the current line up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves the current line down" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "append next line to current line, don't move cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "half page up, cursor in middle" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "half page down, cursor in middle" })
vim.keymap.set("n", "n", "nzzzv", { desc = "repeat Search stay in middle" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "repeat Search opposide stay in middle" })

-- copy, paste and delete with or without (system) clipboard
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste without replacing buffer" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete without copying to buffer" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "copy to system clippboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "copy to system clippboard" })

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- quickfix
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "replace current item"})
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "set current file to executable"})

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, { desc = "apply current file, aka so"})
