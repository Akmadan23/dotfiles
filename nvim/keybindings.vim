" Start/end of line with H/Left
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

" PageUp and PageDown with J/K
nnoremap J <C-d>zz
nnoremap K <C-u>zz
vnoremap J <C-d>zz
vnoremap K <C-u>zz

" Undo with U
nnoremap U <C-r>

" Fixing Y behaviour
nnoremap Y y$

" Disabling Q
nnoremap Q <nop>

" Join lines with dj
nnoremap dj J

" Disabling Ctrl+q for visual block
nnoremap <C-q> <nop>
vnoremap <C-q> <nop>

" Moving between tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT

" Adding visual tabbing
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Moving with vim keys in insert mode
inoremap <A-h> <Left>
inoremap <A-j> <Down>
inoremap <A-k> <Up>
inoremap <A-l> <Right>
inoremap <A-i> <Esc>

" Using Tab to navigate completion menus
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" Moving between splits
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Automatic centering when cycling between search highlights
nnoremap n nzz
nnoremap N Nzz

" Select all command
nnoremap <C-a> ggVG
inoremap <C-a> <Esc>ggVG

" Emmet key
nnoremap <A-z> <C-y>,
inoremap <A-z> <C-y>,

nnoremap <silent><Space> za
nnoremap <C-Space> zR

" Abbreviations in command mode
cabbr W w
cabbr Q q
cabbr Qa qa
cabbr QA qa
cabbr Wq wq
cabbr WQ wq
cabbr Wa wa
cabbr WA wa
cabbr Wqa wqa
cabbr WQa wqa
cabbr WQA wqa

" Disabling arrow keys
nnoremap <Up> <nop>
vnoremap <Up> <nop>
nnoremap <Down> <nop>
vnoremap <Down> <nop>
nnoremap <Left> <nop>
vnoremap <Left> <nop>
nnoremap <Right> <nop>
vnoremap <Right> <nop>

" Disabling enter and backspace
nnoremap <Return> <nop>
vnoremap <Return> <nop>
nnoremap <BackSpace> <nop>
vnoremap <BackSpace> <nop>

