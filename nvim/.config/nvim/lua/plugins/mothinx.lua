return {
  -- gruvbox colorscheme
  { "ellisonleao/gruvbox.nvim" },

  -- load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- telescope
  { "nvim-telescope/telescope.nvim" },

  -- add telescope-fzf
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  {
    "github/copilot.vim",
  },
}
