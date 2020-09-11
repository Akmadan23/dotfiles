"""""" MODULES

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/keybindings.vim

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

colorscheme molokai-teal " fork of molokai theme "
lua require'colorizer'.setup()
hi Normal ctermbg=NONE guibg=NONE

let g:airline_theme = 'molokai'
let g:Hexokinase_highlighters = ['backgroundfull']
let g:Hexokinase_optOutPatterns = 'colour_names'
let g:Hexokinase_refreshEvents = ['BufWrite', 'BufRead', 'TextChanged', 'InsertLeave']

