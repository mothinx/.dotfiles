return {
  "nvim-mini/mini.nvim",
  version = "*", -- Pinning to latest git commit
  config = function()
    -- Setup only the modules you want to use
    require("mini.statusline").setup()
  end,
}