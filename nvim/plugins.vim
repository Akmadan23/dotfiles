call plug#begin('~/.config/nvim/autoload/plugged')
    Plug 'mhinz/vim-startify'
    Plug 'sheerun/vim-polyglot'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'vimwiki/vimwiki'
    Plug 'mattn/calendar-vim'
    Plug 'powerman/vim-plugin-AnsiEsc'

    " LSP Completion
    Plug 'neovim/nvim-lspconfig'
    Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
    Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

    " dev tools
    Plug 'jiangmiao/auto-pairs'
    Plug 'alvan/vim-closetag'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'mattn/emmet-vim'
    Plug 'Yggdroot/indentLine'

    " appearance plugins
    Plug 'rrethy/vim-hexokinase', {'do': 'make hexokinase'}
    Plug 'flazz/vim-colorschemes'
    Plug 'sersorrel/vim-lilypond'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
call plug#end()

lua << EOF
require('lspconfig').vimls.setup                {}
require('lspconfig').texlab.setup               {}
require('lspconfig').clangd.setup               {}
require('lspconfig').phpactor.setup             {}
require('lspconfig').emmet_ls.setup             {}
require('lspconfig').rust_analyzer.setup        {}
require('lspconfig').jedi_language_server.setup {}
require('lspconfig').java_language_server.setup {}
