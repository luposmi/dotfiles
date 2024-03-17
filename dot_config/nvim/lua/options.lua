-- Hint: use `:h <option>` to figure out the meaning if needed
vim.opt.clipboard = 'unnamedplus' -- use system clipboard
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.mouse = 'a'               -- allow the mouse to be used in Nvim

-- Tab
vim.opt.tabstop = 4           -- number of visual spaces per TAB
vim.opt.softtabstop = 4       -- number of spacesin tab when editing
vim.opt.shiftwidth = 4        -- insert x spaces on tab
vim.opt.expandtab = true      -- tabs are spaces
vim.opt.smartindent = true    -- advanced auto indent

-- Undo history
vim.opt.swapfile = false      -- Use a swapfile for the buffer.
vim.opt.backup = false
vim.opt.undodir =
    os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- UI config
vim.opt.number = true         -- show absolute number
vim.opt.relativenumber = true -- add numbers to each line on the left side
vim.opt.cursorline = false    -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true     -- open new vertical split bottom
vim.opt.splitright = true     -- open new horizontal splits right
vim.opt.termguicolors = true  -- enable 24-bit RGB color in the TUI
vim.opt.showmode = false      -- we are experienced, wo don't need the "-- INSERT --" mode hint

-- Scrolling
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Searching
vim.opt.incsearch = true      -- search as characters are entered
vim.opt.hlsearch = true       -- do highlight matches
vim.opt.ignorecase = true     -- ignore case in searches by default
vim.opt.smartcase = true      -- but make it case sensitive if an uppercase is entered

-- Column
vim.opt.colorcolumn = "120"   -- the column to signal you should wrap
