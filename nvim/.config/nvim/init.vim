" Hightlight syntax
syntax on 
" Show line numbers
set number
" Relative line numbers
set relativenumber
" Hilghlight all results
set hlsearch
" Ignore case in search
set ignorecase
" Show search results as you type
set incsearch
" Disable swapfile
set noswapfile
set hidden
" Disable vim sound
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set scrolloff=8
set colorcolumn=80
set signcolumn=yes

lua require('plugins')

let mapleader=" "

" Run :PackerCompile when plugins.lua is updated
augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
