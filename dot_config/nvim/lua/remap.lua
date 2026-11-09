vim.g.mapleader = " "

-- Open the same task composer used by the shell command t.
vim.keymap.set("n", "<leader>ta", function()
    local command = vim.fn.expand("~/.config/scripts/t")
    if vim.fn.executable(command) ~= 1 then
        vim.notify("Task composer is missing: " .. command, vim.log.levels.ERROR)
        return
    end
    vim.cmd("botright 16new")
    local buffer = vim.api.nvim_get_current_buf()
    vim.bo[buffer].bufhidden = "wipe"
    vim.fn.jobstart({ command, "a" }, {
        term = true,
        on_exit = function(_, code)
            if code == 0 then
                vim.schedule(function()
                    if vim.api.nvim_buf_is_valid(buffer) then
                        vim.api.nvim_buf_delete(buffer, { force = true })
                    end
                end)
            end
        end,
    })
    vim.cmd("startinsert")
end, { desc = "Add Taskwarrior task" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves the current line up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves the current line down" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "append next line to current line, don't move cursor" })
vim.keymap.set("n", "<C-u>", "24jzz", { desc = "half page up, cursor in middle" })
vim.keymap.set("n", "<C-i>", "24kzz", { desc = "half page down, cursor in middle" })
vim.keymap.set("n", "n", "nzzzv", { desc = "repeat Search stay in middle" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "repeat Search opposide stay in middle" })

-- copy, paste and delete with or without (system) clipboard
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste without replacing buffer" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete without copying to buffer" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "copy to system clippboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "copy to system clippboard" })

vim.keymap.set("n", "<C-g>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- quickfix
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "replace current item" })
vim.keymap.set("n", "<leader><leader>",
    function()
        vim.cmd("so"); local patcher = require("lazy-local-patcher"); patcher.restore_all(); patcher.apply_all();
    end, { desc = "apply current file, aka so" })

vim.keymap.set("n", "<leader>m", ":marks<CR>", { desc = "show marks" })


-- window navigation
vim.keymap.set("n", "<C-S-h>", "<C-w>h", { desc = "go left one window" })
vim.keymap.set("n", "<C-S-j>", "<C-w>j", { desc = "go down one window" })
vim.keymap.set("n", "<C-S-k>", "<C-w>k", { desc = "go up one window" })
vim.keymap.set("n", "<C-S-l>", "<C-w>l", { desc = "go right one window" })
vim.keymap.set("n", "<C-S-q>", "<C-w>q", { desc = "close window" })

-- Reflow the selection or current paragraph to 120 columns.
vim.keymap.set({ "n", "x" }, "<leader>af", function()
    local textwidth = vim.bo.textwidth
    vim.bo.textwidth = 120
    -- gw uses Neovim's paragraph formatter, independent of LSP/external formatters.
    local command = vim.fn.mode() == "n" and "normal! gwip" or "normal! gw"
    local ok, err = pcall(vim.cmd, command)
    vim.bo.textwidth = textwidth
    if not ok then
        vim.notify(tostring(err), vim.log.levels.ERROR)
    end
end, { desc = "Reflow selection or paragraph to 120 columns" })
