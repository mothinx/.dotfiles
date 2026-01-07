return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Telescope [f]ind [f]iles" },
    { "<leader>fa", function() require("telescope.builtin").find_files({ hidden = true }) end, desc = "Telescope find All files" },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Telescope live grep" },
    { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Telescope buffers" },
    { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Telescope help tags" },
    { "<leader>fd", function() require("telescope.builtin").find_files({hidden = true, cwd = "~/.dotfiles"}) end, desc = "Telescope [f]ind [d]otfiles" },
    { "<leader>ft", function() require("telescope.builtin").find_files({ cwd = "~/thot" }) end, desc = "Telescope [f]ind [t]hot" },
  },
}