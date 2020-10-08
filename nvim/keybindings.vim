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
nnoremap <C-e> :CocCommand explorer<CR>
inoremap <C-e> <Esc>:CocCommand explorer<CR>
vnoremap <C-e> <Esc>:CocCommand explorer<CR>

" Moving between splits
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

nnoremap <C-a> ggVG
inoremap <C-a> <Esc>ggVG

" Emmet key
nnoremap <A-z> <C-y>,
inoremap <A-z> <C-y>,

cnoremap Q q
cnoremap W w

nnoremap q: <nop>

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

