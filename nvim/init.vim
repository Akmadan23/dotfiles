"""""" PUGINS

call plug#begin('~/.config/nvim/autoload/plugged')
    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
    Plug 'sheerun/vim-polyglot'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'flazz/vim-colorschemes'

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

colorscheme molokai
hi Normal ctermbg=NONE guibg=NONE

let g:airline_theme = 'molokai'
let g:Hexokinase_highlighters = ['backgroundfull']
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba'
let g:Hexokinase_refreshEvents = ['BufWrite', 'BufRead', 'TextChanged', 'InsertLeave']

"""""" KEY BINDINGS

nmap U <C-r>
nmap Y y$
nmap H 0
nmap J <S-Down>
nmap K <S-Up>
nmap L $
nmap Q <nop>

vmap <Tab> >
vmap <S-Tab> <

imap ii <Esc>

" cnoremap gs<CR> G status
" cnoremap ga<CR> G add
" cnoremap gc<CR> G commit
" cnoremap gca<CR> G commit -a
" cnoremap gpom<CR> G push ori<CR> Gin master

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

nmap <Return> <nop>
nmap <Space> <nop>
