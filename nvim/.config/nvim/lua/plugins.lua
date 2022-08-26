vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manager itself
    use 'wbthomason/packer.nvim'

    -- Dracula theme
    use 'dracula/vim'
end)
