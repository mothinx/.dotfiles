return {
  "stevearc/oil.nvim",
  cmd = "Oil", -- To load the plugin when using the command
  keys = {
    { "`", "<CMD>Oil<CR>", desc = "Open parent directory" },
  },
  config = function()
    require("oil").setup()
  end,
}