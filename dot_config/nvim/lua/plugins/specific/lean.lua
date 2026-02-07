return {
  'Julian/lean.nvim',
  event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
    'nvim-telescope/telescope.nvim', -- for 2 Lean-specific pickers
  },

  ---@type lean.Config
  opts = { -- see below for full configuration options
    mappings = true,
  }
}
