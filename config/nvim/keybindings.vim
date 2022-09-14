" Leader key
let g:mapleader = ' '

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

" Disable Q and map <c-q> to q
nno Q <nop>
nno q <cmd>echo "For macros and cmdwin use <\c-q>"<cr>
nno <c-q> q

" Undo with U
nno U <c-r>

" Fix Y behaviour
nno Y y$

" Join lines with dj
nno dj J

" Automatic centering when cycling between search highlights
nno n nzz
nno N Nzz

" Remove search highlights with backspace
nno <bs> <cmd>nohlsearch<cr>

" Toggle wrap
nno <a-w> <cmd>set wrap! <bar> echo &wrap ? "Wrap enabled" : "Wrap disabled"<cr>

" Quit insert mode
ino <a-i> <esc>

" Select all command
nno <c-a> ggVG

" Reload config
nno <c-r> <cmd>source ~/.config/nvim/init.vim <bar> echo "Config reloaded."<cr>

" Move between tabs
nno <tab>   gt
nno <s-tab> gT

" Add visual tabbing
vno <tab>   >gv
vno <s-tab> <gv

" FZF
nno <leader>f <cmd>FZF<cr>
nno <leader>F <cmd>FZF ~<cr>

" Packer
nno <leader>pc <cmd>PackerCompile<cr>
nno <leader>ps <cmd>PackerSync<cr>

" Functions
nno <F5> <cmd>call Compile()<cr>
nno <F6> <cmd>call Run()<cr>

" Increase and decrease values
nno <a-+> <c-a>
vno <a-+> <c-a>
nno <a--> <c-x>
vno <a--> <c-x>

" Move between splits
nno <c-h> <c-w>h
nno <c-j> <c-w>j
nno <c-k> <c-w>k
nno <c-l> <c-w>l

" Disable keys
nno <up>    <nop>
vno <up>    <nop>
nno <down>  <nop>
vno <down>  <nop>
nno <left>  <nop>
vno <left>  <nop>
nno <right> <nop>
vno <right> <nop>
nno <space> <nop>
vno <space> <nop>
nno <c-z>   <nop>
vno <c-z>   <nop>

" Terminal bindings 
tno <esc> <c-\><c-n>

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
ca t    tabnew
