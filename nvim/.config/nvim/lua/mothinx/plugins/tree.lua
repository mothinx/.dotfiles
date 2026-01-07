return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFindFile", "NvimTreeFocus" },
  config = function()
    require("nvim-tree").setup()
  end,
}