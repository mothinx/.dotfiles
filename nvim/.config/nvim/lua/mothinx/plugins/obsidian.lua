return {
  "obsidian-nvim/obsidian.nvim",
  event = {
    -- Lazy-load obsidian for files in the vault
    "BufReadPre " .. vim.fn.expand("~") .. "/thot/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/thot/**.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("obsidian").setup({
      workspaces = {
        {
          name = "thot",
          path = "~/thot",
        },
      },
      legacy_commands = false,
    })
  end,
}