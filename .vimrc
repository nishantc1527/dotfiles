" Btw, if you don't install some of these, you won't get an error. It's just for functionality.
"
" THINGS TO INSTALL:
" 1. pylint: pip install pylint
" 2. javac: using your package manager.
" 3. shellcheck: using your package manager.
" 4. Clang, gcc: using your package manager.
" 5. Cargo, rustc, rustfmt: using rustup (or something else, but rustup is recommended)

" --------------------------------------------------------------------- PLUGINS

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
Plug 'majutsushi/tagbar'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'tpope/vim-fugitive'
Plug 'chiel92/vim-autoformat'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ervandew/supertab'
Plug 'prabirshrestha/asyncomplete.vim'

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
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
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

" Shorten error/warning flags
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
" I have some custom icons for errors and warnings but feel free to change them.
let g:ale_sign_error = '✘✘'
let g:ale_sign_warning = '⚠⚠'

" Disable or enable loclist at the bottom of vim
" Comes down to personal preferance.
let g:ale_open_list = 0
let g:ale_loclist = 0

nnoremap <leader>d :ALEGoToDefinition<CR>

" Setup compilers for languages
let g:ale_linters = {
      \  'python': ['pylint'],
      \  'java': ['javac'],
      \ 'sh': ['shellcheck'],
      \ 'cpp': ['clang', 'gcc'],
      \ 'rust': ['cargo', 'rustc', 'rustfmt']
      \ }

" ---------------------------------------------------------------- NERD TREE

" Open when no files were speficied on vim launch
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let NERDTreeShowHidden=1

" ----------------------------------------------------------------- MAPPINGS

" move buffers with <leader><direction>
nnoremap <leader>h :wincmd h<cr>
nnoremap <leader>j :wincmd j<cr>
nnoremap <leader>k :wincmd k<cr>
nnoremap <leader>l :wincmd l<cr>

" Open Terminal With <leader>s
nnoremap <leader>s :term<cr>

" Toggle Nerd Tree With <leader>t
nnoremap <leader>t :NERDTreeToggle<cr>

" Open Vimrc With <leader>ev
nnoremap <leader>ev :e ~/.vimrc<cr>

" Sort Using <leader>s
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

" Ctrl-b to open Tagbar
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

nnoremap <leader>sp mm[s1z=`m<cr>
