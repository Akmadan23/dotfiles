nnoremap H 0
nnoremap J <PageDown>
nnoremap K <PageUp>
nnoremap L $

nnoremap U <C-r>
nnoremap Y y$
nnoremap Q <nop>

nnoremap <C-q> <nop>
vnoremap <C-q> <nop>

vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Moving with vim keys in insert mode
inoremap <A-i> <Esc>
inoremap <A-h> <Left>
inoremap <A-j> <Down>
inoremap <A-k> <Up>
inoremap <A-l> <Right>

" coc-explorer toggle keybinding
nmap <C-e> :CocCommand explorer<CR>
imap <C-e> <Esc>:CocCommand explorer<CR>
vmap <C-e> <Esc>:CocCommand explorer<CR>

" Moving between splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-a> ggVG

" Emmet key
nmap <A-z> <C-y>,
imap <A-z> <C-y>,

cmap Q q
cmap W w

nmap q: <nop>

"""""" Disabling arrow keys

inoremap <Up> <nop>
nnoremap <Up> <nop>
vnoremap <Up> <nop>

inoremap <Down> <nop>
nnoremap <Down> <nop>
vnoremap <Down> <nop>

inoremap <Left> <nop>
nnoremap <Left> <nop>
vnoremap <Left> <nop>

inoremap <Right> <nop>
nnoremap <Right> <nop>
vnoremap <Right> <nop>

inoremap <PageUp> <nop>
nnoremap <PageUp> <nop>
vnoremap <PageUp> <nop>

inoremap <PageDown> <nop>
nnoremap <PageDown> <nop>
vnoremap <PageDown> <nop>

