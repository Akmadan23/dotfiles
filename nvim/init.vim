" Basic settings
set hidden
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
set clipboard+=unnamedplus

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

" Sourcing theme, plugins, functions and keybindings
source ~/.config/nvim/theme.vim
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/functions.vim
source ~/.config/nvim/keybindings.vim

" Automatic insert mode in terminal buffers
autocmd BufEnter term://* startinsert | set nonumber

" COQ
let g:coq_settings = {
    \ 'auto_start': 'shut-up',
    \ 'keymap.recommended': v:true,
    \ }

" Hexokinase
let g:Hexokinase_highlighters = ['backgroundfull']
let g:Hexokinase_optOutPatterns = 'colour_names'

" Closetag
let g:closetag_filetypes = 'html, xml, php'

" Man.vim
let g:no_man_maps = 1

" Airline
let g:airline_theme = 'molokai'
let g:airline_powerline_fonts = 0
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''

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
if (expand('%:e') == 'rasi')
    set ft=css
endif
