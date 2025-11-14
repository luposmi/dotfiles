vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.core",
    callback = function()
        vim.bo.filetype = "yaml"
    end,
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.zshrc",
    callback = function()
        vim.bo.filetype = "zsh"
    end,
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.kdl",
    callback = function ()
        vim.bo.filetype = "kdl"
        vim.cmd("TSBufEnable highlight");
    end
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
        pattern = "*.tmpl",
    callback = function (args)
        name = args.file
        name_without_tmpl = string.gsub(name,".tmpl","")
        vim.bo.filetype = vim.filetype.match({ filename= name_without_tmpl})
    end
})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.md",
    callback = function ()
        -- vim.cmd("colorscheme rose-pine")
    end
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "verilog", "systemverilog" },
  callback = function()
    vim.lsp.start({
      name = "verible",
      cmd = { vim.fn.stdpath("data") .. "/mason/bin/verible-verilog-ls" },
      root_dir = vim.fs.root(0, { ".git", "verible.config", "compile_commands.json" }),
    })
  end,
})

