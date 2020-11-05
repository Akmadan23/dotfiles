nnoremap H 0
nnoremap J <C-d>zz
nnoremap K <C-u>zz
nnoremap L $

nnoremap U <C-r>
nnoremap Y y$
nnoremap Q <nop>
nnoremap dj J

" Disabling Ctrl+q for visual block
nnoremap <C-q> <nop>
vnoremap <C-q> <nop>

" Adding standard tabbing
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Moving with vim keys in insert mode
inoremap <A-h> <Left>
inoremap <A-j> <Down>
inoremap <A-k> <Up>
inoremap <A-l> <Right>
inoremap <A-i> <Esc>

" coc-explorer toggle
nnoremap <C-e> :CocCommand explorer<CR>
inoremap <C-e> <Esc>:CocCommand explorer<CR>
vnoremap <C-e> <Esc>:CocCommand explorer<CR>

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

" Disabling the q: command
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

