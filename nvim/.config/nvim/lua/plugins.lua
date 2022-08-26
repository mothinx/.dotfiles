vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manager itself
    use 'wbthomason/packer.nvim'

    -- LSP for eclipse.jdt.ls (Java)
    use {
        'mfussenegger/nvim-jdtls',
        disable = false,
        ft = "java"
    }

    -- Dracula theme
    use 'dracula/vim'
end)
