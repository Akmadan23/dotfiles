" Basic settings
set hidden
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

" Setting filetype to css in rofi stylesheets
if expand('%:e') == 'rasi'
    set ft=css
endif

" Disabling custom mappings defined by sersorrel/vim-lilypond
if expand('%:e') == 'ly'
    let b:did_ftplugin = 1
endif

" Sourcing theme, plugins, functions and keybindings
source ~/.config/nvim/theme.vim
source ~/.config/nvim/plugins.lua
source ~/.config/nvim/functions.vim
source ~/.config/nvim/keybindings.vim

" Automatic insert mode in terminal buffers
autocmd BufEnter term://* startinsert | set nonumber

" Enabling custom mappings for FZF
autocmd FileType fzf call FZF_map()

" COQ
let g:coq_settings = {
    \ 'auto_start': 'shut-up',
    \ 'keymap.recommended': v:false,
    \ 'display.preview.border': 'double',
    \ 'display.ghost_text.context': [' < ', ' > ']
    \ }

" Hexokinase
let g:Hexokinase_highlighters = ['backgroundfull']
let g:Hexokinase_optOutPatterns = 'colour_names'

" Closetag
let g:closetag_filetypes = 'html, xml, php'

" Man.vim
let g:no_man_maps = 1

" Emmet key
let g:user_emmet_leader_key = '<c-e>'

" IndentLine
let g:indent_blankline_max_indent_increase = 1
let g:indent_blankline_show_first_indent_level = v:false
let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:indent_blankline_filetype_exclude = ['help', 'man', 'markdown', 'vimwiki', 'tex', 'startify']

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
    \ {'type': 'files',     'header': ['   Recent files']},
    \ {'type': 'sessions',  'header': ['   Sessions']}
    \ ]
