" Start/end of line with H/Left
nno H ^
nno L $
vno H ^
vno L $

" PageUp and PageDown with J/K
nno J <C-d>zz
nno K <C-u>zz
vno J <C-d>zz
vno K <C-u>zz

" Undo with U
nno U <C-r>

" Fixing Y behaviour
nno Y y$

" Disabling Q
nno Q <nop>

" Join lines with dj
nno dj J

" Disabling Ctrl+q for visual block
nno <C-q> <nop>
vno <C-q> <nop>

" Moving between tabs
nno <Tab> gt
nno <S-Tab> gT

" Adding visual tabbing
vno <Tab> >gv
vno <S-Tab> <gv

" Moving with vim keys in insert mode
ino <A-h> <Left>
ino <A-j> <Down>
ino <A-k> <Up>
ino <A-l> <Right>
ino <A-i> <Esc>

" Moving between splits
nno <C-h> <C-w>h
nno <C-j> <C-w>j
nno <C-k> <C-w>k
nno <C-l> <C-w>l

" Using Tab to navigate completion menus
ino <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
ino <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" Automatic centering when cycling between search highlights
nno n nzz
nno N Nzz

" Select all command
nno <C-a> ggVG
ino <C-a> <Esc>ggVG

" Increasing and decreasing values
nno <A-+> <C-a>
nno <A--> <C-x>

" Folding
nno <silent><Space> za
nno <C-Space> zR

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
