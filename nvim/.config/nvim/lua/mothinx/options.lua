vim.g.mapleader = " " -- space leader key
vim.o.termguicolors = true -- 24-bit colors
vim.o.tabstop = 2 -- tab inserts
vim.o.softtabstop = 2 -- tab inserts
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.scrolloff = 8 -- keep lines above/below cursor
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.swapfile = false
vim.diagnostic.config({ virtual_text = true}) -- inline diagnostics
vim.g.have_nerd_font = true -- Nerd font
vim.o.mouse = 'a' -- Usefull for resizing splits
vim.schedule(function()        -- Share the os and neovim clipboard
vim.o.clipboard = 'unnamedplus'
end)
vim.o.showmode = false -- it's already in the statusline

