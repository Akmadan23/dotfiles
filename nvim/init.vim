"""""" PUGINS

call plug#begin('~/.config/nvim/autoload/plugged')
    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
    Plug 'sheerun/vim-polyglot'
    Plug 'scrooloose/NERDTree'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
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
hi Normal ctermbg=NONE guibg=NONE

let g:airline_theme = 'codedark'
let g:Hexokinase_highlighters = ['backgroundfull']
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla,'

"""""" KEY BINDINGS

nmap U <C-r>
nmap Y y$
nmap H 0
nmap J <S-Down>
nmap K <S-Up>
nmap L $

vmap <Tab> >
vmap <S-Tab> <
imap ii <Esc>

cmap gs G status
cmap ga G add
cmap gc G commit
cmap gca G commit -a
cmap gpom G push origin master

"""""" Disabling arrow keys

inoremap <up> <nop>
nnoremap <up> <nop>
vnoremap <up> <nop>

inoremap <down> <nop>
nnoremap <down> <nop>
vnoremap <down> <nop>

inoremap <left> <nop>
nnoremap <left> <nop>
vnoremap <left> <nop>

inoremap <right> <nop>
nnoremap <right> <nop>
vnoremap <right> <nop>

inoremap <PageUp> <nop>
nnoremap <PageUp> <nop>
vnoremap <PageUp> <nop>

inoremap <PageDown> <nop>
nnoremap <PageDown> <nop>
vnoremap <PageDown> <nop>

