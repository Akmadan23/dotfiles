call plug#begin('~/.config/nvim/autoload/plugged')
    Plug 'sheerun/vim-polyglot'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'preservim/nerdtree'
    Plug 'ryanoasis/vim-devicons'

    " dev tools
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'jiangmiao/auto-pairs'
    Plug 'alvan/vim-closetag'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'airblade/vim-gitgutter'
    Plug 'mattn/emmet-vim'

    " appearance plugins
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'flazz/vim-colorschemes'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
call plug#end()
