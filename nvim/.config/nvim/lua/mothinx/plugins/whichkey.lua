return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    local wk = require("which-key")

    wk.setup {
      -- your configuration comes here
      -- for example, if you want to set keymaps that are not targeted to a specific plugin
      -- you can do it here
    }

    -- Example mapping:
    wk.add({
      { "<leader>f", group = "[F]ind" },
      { "<leader>w", group = "[W]orkspace" },
      { "<leader>g", group = "[G]it" },
      { "<leader>t", group = "[T]oggle" },
      { "<leader>s", group = "[S]earch" },
    })

    -- Add the existing keymaps to which-key
    wk.add({
      { "<C-s>", "<cmd>w<CR>", desc = "Save file" },
      { "<leader>q", "<cmd>qa<CR>", desc = "Quit Neovim" },
    })
  end,
}