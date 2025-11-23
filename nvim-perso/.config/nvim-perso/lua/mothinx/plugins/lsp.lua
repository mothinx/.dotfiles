require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {"lua_ls", "ts_ls", "pyright", "jdtls"}
})

vim.lsp.config['lua_ls'] = {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("",true),
      }
    }
  }
}
