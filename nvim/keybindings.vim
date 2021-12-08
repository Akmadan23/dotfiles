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

" Toggle wrap
nno <a-w> <cmd>set wrap! <bar> echo &wrap ? "Wrap enabled" : "Wrap disabled"<cr>

" Quit insert mode
ino <a-i> <esc>

" Select all command
nno <c-a> ggVG

" Reload config
nno <silent><c-r> <cmd>source ~/.config/nvim/init.vim <bar> echo "Config reloaded."<cr>

" Disabling Ctrl+q for visual block
nno <c-q> <nop>
vno <c-q> <nop>

" Moving between tabs
nno <tab>   gt
nno <s-tab> gT

" Adding visual tabbing
vno <tab>   >gv
vno <s-tab> <gv

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

" Disabling keys
nno <cr>    <nop>
vno <cr>    <nop>
nno <bs>    <nop>
vno <bs>    <nop>
nno <up>    <nop>
vno <up>    <nop>
nno <down>  <nop>
vno <down>  <nop>
nno <left>  <nop>
vno <left>  <nop>
nno <right> <nop>
vno <right> <nop>

" Terminal bindings 
tno <esc> <c-\><c-n>

" popup menu
ino <silent><expr><esc>     pumvisible() ? "\<c-e><esc>" : "\<esc>"
ino <silent><expr><c-c>     pumvisible() ? "\<c-e><c-c>" : "\<c-c>"
ino <silent><expr><bs>      pumvisible() ? "\<c-e><bs>"  : "\<bs>"
ino <silent><expr><cr>      pumvisible() ? "\<c-y>" : "\<cr>"
ino <silent><expr><tab>     pumvisible() ? "\<c-n>" : "\<tab>"
ino <silent><expr><s-tab>   pumvisible() ? "\<c-p>" : "\<bs>"

" Command mode abbreviations
ca H    h
ca W    w
ca Q    q
ca Qa   qa
ca QA   qa
ca Wq   wq
ca WQ   wq
ca Wa   wa
ca WA   wa
ca Wqa  wqa
ca WQa  wqa
ca WQA  wqa
