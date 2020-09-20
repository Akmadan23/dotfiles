"     _    _                        _             ____  _____ 
"    / \  | | ___ __ ___   __ _  __| | __ _ _ __ |___ \|___ / 
"   / _ \ | |/ / '_ ` _ \ / _` |/ _` |/ _` | '_ \  __) | |_ \ 
"  / ___ \|   <| | | | | | (_| | (_| | (_| | | | |/ __/ ___) |
" /_/   \_\_|\_\_| |_| |_|\__,_|\__,_|\__,_|_| |_|_____|____/ 

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/keybindings.vim
source ~/.config/nvim/coc.vim

syntax enable
set hidden
set nowrap
set encoding=UTF-8
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

colorscheme molokai-teal
lua require 'colorizer'.setup()
hi Normal ctermbg=NONE guibg=NONE

" Airline settings
let g:airline_theme = 'molokai'
let g:airline_powerline_fonts = 1

" NERDTree custom mappings
let g:NERDTreeMapActivateNode = 'l'
let g:NERDTreeMapOpenSplit = 'h'
let g:NERDTreeMapOpenVSplit = 'v'

