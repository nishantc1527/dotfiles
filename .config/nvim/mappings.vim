inoremap jk <esc>
inoremap kj <esc>

inoremap <esc> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l

vnoremap <leader>s :sort<cr>

nnoremap <TAB> :bnext<cr>
nnoremap <S-TAB> :bprevious<cr>

noremap <c-s> :w<cr>

vnoremap < <gv
vnoremap > >gv

nnoremap <leader>s :split<cr>:terminal<cr>$a

nnoremap <leader>ev :e $MYVIMRC<cr>
