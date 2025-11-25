-- Keymaps for saving file
vim.keymap.set({"n", "i", "v"}, "<C-s>", ":w<CR>", { silent = true, noremap = true })

-- Keymap to quit Neovim
vim.keymap.set("n", "<leader>q", ":qa<CR>", { silent = true, noremap = true })