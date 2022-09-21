" Basic settings
set nowrap
set number
set incsearch
set ignorecase
set cursorline
set nocursorcolumn
set termguicolors
set noshowmode
set nobackup
set background=dark
set mouse=a
set encoding=UTF-8
set shortmess+=c
set clipboard=unnamedplus
set completeopt=menuone
set colorcolumn=10000

" Splits
set splitbelow
set splitright

" Tabs
set expandtab
set tabstop=4
set shiftwidth=4

" Indent
set smartindent
set autoindent

" Folding
set foldmethod=indent
set foldnestmax=10
set foldlevel=100
set nofoldenable

" Color scheme
color monokai

" Plugins, functions and keybindings
source ~/.config/nvim/plugins.lua
source ~/.config/nvim/functions.lua
source ~/.config/nvim/keybindings.lua

" Autocommands 
au BufEnter *.rasi      set ft=css                  " Set filetype to css in rofi stylesheets
au BufEnter term://*    start | set nonumber        " Automatic insert mode in terminal buffers
au FileType lilypond    setl commentstring=\%\ %s   " Set comment pattern for lilypond files
au FileType nim         setl commentstring=#\ %s    " Set comment pattern for nim files
