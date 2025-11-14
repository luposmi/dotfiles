require("options")
require("remap")
require("filetypes")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup( {

    spec = {
        {import = "plugins"},
        {import = "plugins/editing"},
        {import = "plugins/language-server"},
        {import = "plugins/menus"},
        {import = "plugins/specific"},
        {import = "plugins/visual"},

    }
})

vim.treesitter.language.register("bash", "zsh")


vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.core",
    callback = function()
        vim.bo.filetype = "yaml"
    end,
})

vim.o.clipboard = "unnamedplus"

local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}

vim.cmd("colorscheme  catppuccin-macchiato")
vim.api.nvim_set_hl(0, "LineNr", { fg = "#cad3f5" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e9effa", bold = true })


vim.cmd("highlight link @markup.quote.markdown Normal")
