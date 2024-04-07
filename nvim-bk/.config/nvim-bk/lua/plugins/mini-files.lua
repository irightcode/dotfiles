return {
  "echasnovski/mini.nvim",
  enabled = false,
  version = "*",
  config = function()
    require("mini.files").setup()
  end,
}
