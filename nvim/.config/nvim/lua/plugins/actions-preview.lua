return {
  "aznhe21/actions-preview.nvim",
  lazy = false,
  disabled = true,
  enabled = false,
  opts = {},
  config = function()
    vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
  end,
}
