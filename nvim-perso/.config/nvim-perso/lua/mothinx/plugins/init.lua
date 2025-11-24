vim.pack.add({
	{src = "http://github.com/neovim/nvim-lspconfig"},
	{src = "http://github.com/mason-org/mason.nvim"},
	{src = "http://github.com/mason-org/mason-lspconfig.nvim"},
	{src = "http://github.com/WhoIsSethDaniel/mason-tool-installer.nvim"},
	{src = "http://github.com/nvim-lua/plenary.nvim"},
	{src = "http://github.com/nvim-telescope/telescope.nvim"},
	{src = "http://github.com/folke/which-key.nvim"},
	{src = "http://github.com/nvim-mini/mini.nvim"},
	{src = "http://github.com/nvim-tree/nvim-tree.lua"},
	{src = "http://github.com/kdheepak/lazygit.nvim"},
	{src = "https://github.com/nvim-treesitter/nvim-treesitter"},
	{src = "https://github.com/obsidian-nvim/obsidian.nvim"},
	{src = "https://github.com/stevearc/oil.nvim"},
  -- Themes loader with Omarchy
	{src = "http://github.com/catppuccin/nvim"},
	{src = "http://github.com/ellisonleao/gruvbox.nvim"},
	{src = "http://github.com/neanias/everforest-nvim"},
	{src = "http://github.com/EskelinenAntti/omarchy-theme-loader.nvim"},
})

require("mothinx.plugins.lsp")
require("mothinx.plugins.tree")
require("mothinx.plugins.telescope")
require("mothinx.plugins.treesitter")
require("mothinx.plugins.mini")
require("mothinx.plugins.oil")
