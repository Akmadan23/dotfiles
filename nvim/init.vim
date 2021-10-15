" Sourcing plugins and keybindings
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/functions.vim
source ~/.config/nvim/keybindings.vim

" Basig settings
syntax enable
set hidden
set number
set ignorecase
set cursorline
set nobackup
set background=dark
set termguicolors
set mouse=a
set encoding=UTF-8
set clipboard+=unnamedplus

" Splits
set splitbelow
set splitright
set incsearch
set noshowmode

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

colorscheme molokai-teal
lua require 'colorizer'.setup()
hi Normal ctermbg=none guibg=none

" Automatic insert mode in terminal buffers
autocmd BufEnter term://* startinsert | set nonumber

" Deoplete
let g:deoplete#enable_at_startup = 1

" Man.vim
let g:no_man_maps = 1

" Airline
let g:airline_theme = 'molokai'
let g:airline_powerline_fonts = 0

" IndentLine
let g:indentLine_fileTypeExclude = ['markdown', 'vimwiki', 'coc-explorer', 'help', 'man', 'tex', 'startify']
let g:indentLine_char = '│'

" WimWiki
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{
    \ 'path': '~/git-repos/vimwiki/notes/',
    \ 'path_html': '~/git-repos/vimwiki/html/'
    \ }]

" Startify
let g:startify_custom_header = startify#pad(split(system('figlet -f poison "Neovim"'), '\n'))
let g:startify_session_dir = '~/.config/nvim/sessions'
let g:startify_lists = [
    \ {'type': 'files', 'header': ['   Recent files']},
    \ {'type': 'sessions', 'header': ['   Sessions']}
    \ ]

" Setting filetype to css in rofi stylesheets
if (expand("%:e") == 'rasi')
    set ft=css
endif
