return {
    "mbbill/undotree",
    config = function()
        local undo_dir = vim.fn.stdpath("data") .. "/undo"
        if vim.fn.isdirectory(undo_dir) == 0 then
            vim.fn.mkdir(undo_dir, "p")
        end

        vim.opt.undodir = undo_dir
        vim.opt.undofile = true
        vim.opt.undolevels = 10000
        vim.opt.undoreload = 10000
        vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end
}
