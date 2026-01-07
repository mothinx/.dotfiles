return {
	-- Mason for managing LSP servers, daps, linters, etc.
	{
		"mason-org/mason.nvim",
		opts = {},
	},

	-- mason-lspconfig to bridge mason and lspconfig
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
	},

	-- nvim-lspconfig, the main LSP configuration plugin
	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-org/mason-lspconfig.nvim" },
		config = function()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = { "lua_ls", "pyright", "jdtls", "gopls" },
				handlers = {
					function(server_name) -- Default handler
						lspconfig[server_name].setup({})
					end,
					["lua_ls"] = function() -- Custom handler for lua_ls
						lspconfig.lua_ls.setup({
							settings = {
								Lua = {
									workspace = {
										library = vim.api.nvim_get_runtime_file("", true),
									},
								},
							},
						})
					end,
				},
			})
		end,
	},
}
