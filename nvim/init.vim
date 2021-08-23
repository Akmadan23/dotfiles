"     _    _                        _             ____  _____ 
"    / \  | | ___ __ ___   __ _  __| | __ _ _ __ |___ \|___ / 
"   / _ \ | |/ / '_ ` _ \ / _` |/ _` |/ _` | '_ \  __) | |_ \ 
"  / ___ \|   <| | | | | | (_| | (_| | (_| | | | |/ __/ ___) |
" /_/   \_\_|\_\_| |_| |_|\__,_|\__,_|\__,_|_| |_|_____|____/ 

call plug#begin('~/.config/nvim/autoload/plugged')
    Plug 'sheerun/vim-polyglot'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'vimwiki/vimwiki'
    Plug 'mattn/calendar-vim'
    Plug 'powerman/vim-plugin-AnsiEsc'
    Plug 'glacambre/firenvim', {'do': {_ -> firenvim#install(0)}}

    " dev tools
    Plug 'jiangmiao/auto-pairs'
    Plug 'alvan/vim-closetag'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
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
    Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}
    Plug 'kristijanhusak/deoplete-phpactor'

    " appearance plugins
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'flazz/vim-colorschemes'
    Plug 'sersorrel/vim-lilypond'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
call plug#end()

syntax enable
set hidden
set nowrap
set encoding=UTF-8
set iskeyword+=-
set mouse=a
set splitbelow
set splitright
set expandtab
set noshowmode
set tabstop=4 
set shiftwidth=4
set smartindent
set autoindent
set ignorecase
set number 
set cursorline
set foldmethod=indent
set foldnestmax=10
set foldlevel=100
set nofoldenable
set nobackup
set background=dark
set clipboard+=unnamedplus
set termguicolors

colorscheme molokai-teal
lua require 'colorizer'.setup()
hi Normal ctermbg=none guibg=none

" Deoplete
let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option('sources', {'php' : ['omni', 'phpactor', 'ultisnips', 'buffer']})

" Man.vim
let g:no_man_maps = 1

" Airline
let g:airline_theme = 'molokai'
let g:airline_powerline_fonts = 0

" IndentLine
let g:indentLine_fileTypeExclude = ['markdown', 'vimwiki', 'coc-explorer', 'help', 'man', 'tex']
let g:indentLine_char = '│'

" WimWiki
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{
    \ 'path': '~/git-repos/vimwiki/notes/',
    \ 'path_html': '~/git-repos/vimwiki/html/'}]

" Sourcing keybindings
source ~/.config/nvim/keybindings.vim
