" Start/end of line with H/L
nno H ^
vno H ^
nno L $
vno L $

" PageUp and PageDown with J/K
nno J <c-d>zz
vno J <c-d>zz
nno K <c-u>zz
vno K <c-u>zz

" Undo with U
nno U <c-r>

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
nno <silent><space> za

" Quit insert mode
ino <a-i> <esc>

" Select all command
nno <c-a> ggVG

" Reload config
nno <c-r> :source ~/.config/nvim/init.vim<cr>

" Disabling Ctrl+q for visual block
nno <c-q> <nop>
vno <c-q> <nop>

" Moving between tabs
nno <tab> gt
nno <s-tab> gT

" Adding visual tabbing
vno <Tab> >gv
vno <S-Tab> <gv

" Using Tab to navigate completion menus
ino <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
ino <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" Increasing and decreasing values
nno <a-+> <c-a>
vno <a-+> <c-a>
nno <a--> <c-x>
vno <a--> <c-x>

" Moving between splits
nno <c-h> <c-w>h
nno <c-j> <c-w>j
nno <c-k> <c-w>k
nno <c-l> <c-w>l

" Disabling arrow keys
nno <up> <nop>
vno <up> <nop>
nno <down> <nop>
vno <down> <nop>
nno <left> <nop>
vno <left> <nop>
nno <right> <nop>
vno <right> <nop>

" Disabling enter and backspace
nno <return> <nop>
vno <return> <nop>
nno <backspace> <nop>
vno <backspace> <nop>

" Terminal bindings 
tno <esc> <c-\><c-n>

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
