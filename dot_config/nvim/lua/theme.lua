vim.cmd("colorscheme  catppuccin-macchiato")
vim.api.nvim_set_hl(0, "LineNr", { fg = "#cad3f5" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e9effa", bold = true })
vim.cmd("highlight link @markup.quote.markdown Normal")
