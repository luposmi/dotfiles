return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.icons").setup()
      require("mini.ai").setup()
      require("mini.surround").setup()
    end,
  },
}
