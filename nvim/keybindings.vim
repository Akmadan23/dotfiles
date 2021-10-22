" Start/end of line with H/L
nno H ^
vno H ^
nno L $
vno L $

" PageUp and PageDown with J/K
nno J <C-d>zz
vno J <C-d>zz
nno K <C-u>zz
vno K <C-u>zz

" Undo with U
nno U <C-r>

" Fixing Y behaviour
nno Y y$

" Disabling Q
nno Q <nop>

" Join lines with dj
nno dj J

" Automatic centering when cycling between search highlights
nno n nzz
nno N Nzz

" Folding
nno <silent><Space> za

" Quit insert mode
ino <A-i> <Esc>

" Select all command
nno <C-a> ggVG

" Reload config
nno <C-r> :source ~/.config/nvim/init.vim<CR>

" Disabling Ctrl+q for visual block
nno <C-q> <nop>
vno <C-q> <nop>

" Moving between tabs
nno <Tab> gt
nno <S-Tab> gT

" Adding visual tabbing
vno <Tab> >gv
vno <S-Tab> <gv

" Using Tab to navigate completion menus
ino <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
ino <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" Increasing and decreasing values
nno <A-+> <C-a>
nno <A--> <C-x>

" Moving between splits
nno <C-h> <C-w>h
nno <C-j> <C-w>j
nno <C-k> <C-w>k
nno <C-l> <C-w>l

" Disabling arrow keys
nno <Up> <nop>
vno <Up> <nop>
nno <Down> <nop>
vno <Down> <nop>
nno <Left> <nop>
vno <Left> <nop>
nno <Right> <nop>
vno <Right> <nop>

" Disabling enter and backspace
nno <Return> <nop>
vno <Return> <nop>
nno <BackSpace> <nop>
vno <BackSpace> <nop>

" Terminal bindings 
tno <Esc> <C-\><C-n>

" Command mode abbreviations
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
