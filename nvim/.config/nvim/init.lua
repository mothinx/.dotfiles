vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.o.winborder = "rounded"

vim.g.mapleader = " "

vim.keymap.set('n', '<leader>so', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')

vim.pack.add({
	{ src = 'https://github.com/ellisonleao/gruvbox.nvim' },
	{ src = 'https://github.com/stevearc/oil.nvim' },
	{ src = 'https://github.com/echasnovski/mini.pick' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/mason-org/mason.nvim' },
	{ src = 'https://github.com/obsidian-nvim/obsidian.nvim' },
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

vim.cmd("set completeopt+=noselect")

require "mini.pick".setup()
require "oil".setup()
require "mason".setup()
require "nvim-treesitter.configs".setup({
	ensure_installed = { "lua", "vim", "vimdoc", "markdown" },
	highlight = { enable = true },
	auto_install = true

})
require "obsidian".setup({
	workspaces = {
		{
			name = "personnal",
			path = "~/thot",
		}
	}
})

vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

vim.lsp.enable({ "lua_ls", "pyright" })
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			}
		}
	}
})

vim.cmd("colorscheme gruvbox")
vim.cmd(":hi statusline guibg=NONE")
