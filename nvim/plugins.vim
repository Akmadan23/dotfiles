call plug#begin('~/.config/nvim/autoload/plugged')
    Plug 'mhinz/vim-startify'
    Plug 'sheerun/vim-polyglot'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'vimwiki/vimwiki'
    Plug 'mattn/calendar-vim'
    Plug 'powerman/vim-plugin-AnsiEsc'

    " dev tools
    Plug 'jiangmiao/auto-pairs'
    Plug 'alvan/vim-closetag'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'mattn/emmet-vim'
    Plug 'Yggdroot/indentLine'

    " deoplete
    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
    Plug 'Shougo/deoplete-clangx'
    Plug 'Shougo/neco-syntax'
    Plug 'Shougo/neco-vim'
    Plug 'lervag/vimtex'
    Plug 'deoplete-plugins/deoplete-jedi'

    " appearance plugins
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'flazz/vim-colorschemes'
    Plug 'sersorrel/vim-lilypond'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
call plug#end()
