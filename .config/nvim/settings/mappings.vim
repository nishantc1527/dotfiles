let mapleader = " "

inoremap jk <esc>
inoremap <esc> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>t :NERDTreeToggle<cr>
nnoremap <leader>s :split<cr>:terminal<cr>$a
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l
nnoremap <c-o> o<esc>
nnoremap / :Lines<cr>
nnoremap <tab> :bnext<cr>
nnoremap <s-tab> :bprevious<cr>
nnoremap <leader>q :bdelete<cr>

vnoremap < <gv
vnoremap > >gv
vnoremap <leader>s :sort<cr>
