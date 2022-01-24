set exrc
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set incsearch
set scrolloff=8
set colorcolumn=80
set signcolumn=yes

call plug#begin('~/.vim/plugged')
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'Mofiqul/dracula.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

colorscheme dracula

let mapleader=","
nnoremap <Leader>ff <cmd>Telescope find_files<cr>
nnoremap <Leader>fh <cmd>Telescope find_files hidden=true<cr>
