" --------------------------------------------------------------------- PLUGINS

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'chiel92/vim-autoformat'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ervandew/supertab'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/vim-lsp'

call plug#end()

" -------------------------------------------------------------------- RANDOM

" Line Number / Relative Line Number Hybrid
set number relativenumber

" Set Tabs To 2
set tabstop=2
set shiftwidth=2
set shiftwidth=2
set shiftround
set expandtab

" Searching
set incsearch
set nohlsearch

" No Swap Files
set noswapfile
set nowritebackup
set noswapfile

filetype plugin indent on

" Open Terminal In The Same Directory
autocmd BufEnter * silent! lcd %:p:h

let mapleader = " "

set nocompatible

set pastetoggle=<F2>
set clipboard=unnamed

set showcmd

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

setlocal spell
set spelllang=en

" ----------------------------------------------------------------- ONE DARK THEME

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on
colorscheme onedark

let g:onedark_hide_endofbuffer = 1
let g:omnedark_terminal_italics = 1

" ---------------------------------------------------------------- LIGHTLINE

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" -------------------------------------------------------------------- ALE

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'

let g:ale_open_list = 0
let g:ale_loclist = 0

nnoremap <leader>d :ALEGoToDefinition<CR>

let g:ale_linters = {
      \  'python': ['pylint'],
      \  'java': ['javac'],
      \ 'sh': ['shellcheck'],
      \ 'cpp': ['clang', 'gcc'],
      \ 'rust': ['cargo', 'rustc', 'rustfmt']
      \ }

" ---------------------------------------------------------------- NERD TREE

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let NERDTreeShowHidden=1

" ----------------------------------------------------------------- MAPPINGS

nnoremap <leader>h :wincmd h<cr>
nnoremap <leader>j :wincmd j<cr>
nnoremap <leader>k :wincmd k<cr>
nnoremap <leader>l :wincmd l<cr>

nnoremap <leader>s :term<cr>

nnoremap <leader>t :NERDTreeToggle<cr>

nnoremap <leader>ev :e ~/.vimrc<cr>

vnoremap <leader>s :sort<cr>

vnoremap < <gv
vnoremap > >gv

inoremap jj <esc>
inoremap <esc> <nop>

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" ------------------------------------------------------------- VIM FUGITIVE

nnoremap <leader>gs :G<cr>
nnoremap <leader>gd :Gdiffsplit<cr>
nnoremap <leader>gf :diffget //2<cr>
nnoremap <leader>gj :diffget //3<cr>

" ------------------------------------------------------------------ TAGBAR

nnoremap <leader>p :TagbarToggle<CR>

" ----------------------------------------------------------------- LSP

if executable('pyls')
  " pip install python-language-server
  au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)

  " refer to doc to add more commands
endfunction

augroup lsp_install
  au!
  " call s:on_lsp_buffer_enabled only for languages that has the server registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

imap <c-space> <Plug>(asyncomplete_force_refresh)

let g:asyncomplete_auto_popup = 0

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" allow modifying the completeopt variable, or it will
" be overridden all the time
let g:asyncomplete_auto_completeopt = 0

set completeopt=menuone,noinsert,noselect,preview

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" ---------------------------------------------------------- AUTOFORMAT

au BufWrite * :Autoformat

" ------------------------------------------------------------- FZF

" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Path completion with custom source command
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

" Word completion with custom spec with pop-up layout option
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})
