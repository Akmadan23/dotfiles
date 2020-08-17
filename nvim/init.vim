"""""" PUGINS

call plug#begin('~/.config/nvim/autoload/plugged')
    Plug 'sheerun/vim-polyglot'
    Plug 'scrooloose/NERDTree'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'flazz/vim-colorschemes'
    Plug 'tomasiser/vim-code-dark'

    " dev tools
    Plug 'jiangmiao/auto-pairs'
    Plug 'alvan/vim-closetag'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'
    Plug 'airblade/vim-gitgutter'
    Plug 'mattn/emmet-vim'
call plug#end()

"""""" GENERAL SETTINGS

syntax enable
set hidden
set nowrap
set encoding=utf-8
set iskeyword+=-
set mouse=a
set splitbelow
set splitright
set tabstop=4                           
set shiftwidth=4
set smartindent
set autoindent
set ignorecase
set number relativenumber 
set cursorline
set nobackup
set background=dark
set clipboard+=unnamedplus
set termguicolors
colorscheme codedark

luafile $HOME/.config/nvim/colorizer.lua
let g:airline_theme = 'codedark'
hi Normal ctermbg=NONE guibg=NONE

"""""" KEY BINDINGS

map U redo
map Y y$
map H 0
map J <S-Down>
map K <S-Up>
map L $

vmap <Tab> >
vmap <S-Tab> <

cmap gs G status
cmap ga G add
cmap gc G commit
cmap gca G commit -a
cmap gpom G push origin master

imap ii <Esc>
