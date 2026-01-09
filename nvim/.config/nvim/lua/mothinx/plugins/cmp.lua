return {
  -- nvim-cmp, the completion engine
   {
     "hrsh7th/nvim-cmp",
     event = "InsertEnter",
     dependencies = {
       "hrsh7th/cmp-nvim-lsp",
       "hrsh7th/cmp-buffer",
       "hrsh7th/cmp-path",
       {
         "Saghen/blink.cmp",
         version = '1.*',
       },
     },
    config = function()
      local cmp = require("cmp")
      -- blink.cmp setup
      require("blink.cmp").setup({
        fuzzy = {
          prebuilt_binaries = {
            force_version = 'v1.8.0'
          }
        }
      })
      cmp.setup({
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "blink" },
        }),
        -- Basic keymappings for completion
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
      })
    end,
  },
}
