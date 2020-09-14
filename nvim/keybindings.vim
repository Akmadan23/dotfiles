nmap H 0
nmap J <S-Down>
nmap K <S-Up>
nmap L $

nmap U <C-r>
nmap Y y$
nmap Q <nop>

nmap <C-q> <nop>
vmap <C-q> <nop>

vmap <Tab> >gv
vmap <S-Tab> <gv

imap <A-i> <Esc>

map <C-n> :NERDTreeToggle<CR>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nmap <A-z> <C-y>,
imap <A-z> <C-y>,

"""""" Disabling arrow keys

inoremap <up> <nop>
nnoremap <up> <nop>
vnoremap <up> <nop>

inoremap <down> <nop>
nnoremap <down> <nop>
vnoremap <down> <nop>

inoremap <left> <nop>
nnoremap <left> <nop>
vnoremap <left> <nop>

inoremap <right> <nop>
nnoremap <right> <nop>
vnoremap <right> <nop>

inoremap <PageUp> <nop>
nnoremap <PageUp> <nop>
vnoremap <PageUp> <nop>

inoremap <PageDown> <nop>
nnoremap <PageDown> <nop>
vnoremap <PageDown> <nop>

"""""" Disabling space return and backspace in normal mode

nnoremap <Space> <nop>
nnoremap <Return> <nop>
nnoremap <Backspace> <nop>

