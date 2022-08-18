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

" Setting color scheme
color monokai

" Sourcing plugins, functions and keybindings
source ~/.config/nvim/plugins.lua
source ~/.config/nvim/functions.vim
source ~/.config/nvim/keybindings.vim

" Autocommands 
au BufEnter *           nno <buffer><F5> <cmd>call Compile()<cr>|nno <buffer><F6> <cmd>call Run()<cr>
au BufEnter *.md        ++once MarkdownPreview      " Starting the markdown preview client just once
au BufEnter *.rasi      set ft=css                  " Setting filetype to css in rofi stylesheets
au BufEnter term://*    start | set nonumber        " Automatic insert mode in terminal buffers
au FileType lilypond    setl commentstring=\%\ %s   " Setting comment pattern for lilypond files
au FileType nim         setl commentstring=#\ %s    " Setting comment pattern for nim files
au FileType fzf         call FZF_map()              " Enabling custom mappings for FZF

" Man.vim
let g:no_man_maps = 1

" Closetag
let g:closetag_filetypes = "html, xml, php"

" Hexokinase
let g:Hexokinase_highlighters = ["backgroundfull"]
let g:Hexokinase_optOutPatterns = "colour_names"

" IndentLine
let g:indent_blankline_max_indent_increase = 1
let g:indent_blankline_show_first_indent_level = v:false
let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:indent_blankline_filetype_exclude = ["help", "man", "markdown", "vimwiki", "tex", "startify"]

" WimWiki
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{
    \ "path": "~/git-repos/vimwiki/notes/",
    \ "path_html": "~/git-repos/vimwiki/html/"
    \ }]