call plug#begin('~/.config/nvim/autoload/plugged')
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
    Plug 'calebsmith/vim-lambdify'
    Plug 'mattn/emmet-vim'

    " appearance
    Plug 'rrethy/vim-hexokinase', {'do': 'make hexokinase'}
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'sheerun/vim-polyglot'
    Plug 'mhinz/vim-startify'

    " misc
    Plug 'vimwiki/vimwiki'
    Plug 'mattn/calendar-vim'
    Plug 'junegunn/fzf.vim'
    Plug 'powerman/vim-plugin-AnsiEsc'
call plug#end()

lua << EOF
require('lualine').vimls.setup                  {}
require('lspconfig').vimls.setup                {}
require('lspconfig').texlab.setup               {}
require('lspconfig').clangd.setup               {}
require('lspconfig').phpactor.setup             {}
require('lspconfig').emmet_ls.setup             {}
require('lspconfig').rust_analyzer.setup        {}
require('lspconfig').jedi_language_server.setup {}
require('lspconfig').java_language_server.setup {}
