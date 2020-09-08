" --------------------------------------------------------------------- PLUGINS

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-gitgutter'
Plug 'andreasvc/vim-256noir'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'chiel92/vim-autoformat'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'dense-analysis/ale'
Plug 'huyvohcmc/atlas.vim'
Plug 'itchyny/lightline.vim'
Plug 'jnurmine/Zenburn'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lifepillar/vim-mucomplete'
Plug 'luochen1990/rainbow'
Plug 'majutsushi/tagbar'
Plug 'mattn/vim-lsp-settings'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'sickill/vim-monokai'
Plug 'tpope/vim-fugitive'

call plug#end()

" -------------------------------------------------------------------- RANDOM SETTINGS

syntax enable

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

let mapleader = " "

set nocompatible

set pastetoggle=<F2>
set clipboard=unnamed

set showcmd

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

setlocal spell
set spelllang=en

" Open Terminal In The Same Directory
autocmd BufEnter * silent! lcd %:p:h

" -------------------------------------------------------------------- GRUVBOX

set background=dark

" ----------------------------------------------------------------- ONE DARK THEME

let g:onedark_hide_endofbuffer = 1
let g:omnedark_terminal_italics = 1

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

" --------------------------------------------------------------- 256 NOIR

" Make the current line black
set cursorline
highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=233 guifg=NONE guibg=#121212
autocmd InsertEnter * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=234 guifg=NONE guibg=#1c1c1c
autocmd InsertLeave * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=233 guifg=NONE guibg=#121212

" ----------------------------------------------------------------- COLORSCHEME

" Change the default colorscheme here. See all available colors by typing
" :Colors.
colorscheme onedark

" ------------------------------------------------------------------ LIGHTLINE

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

" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let NERDTreeShowHidden=1

nnoremap <leader>t :NERDTreeToggle<cr>

" ----------------------------------------------------------------- MAPPINGS

nnoremap <leader>h :wincmd h<cr>
nnoremap <leader>j :wincmd j<cr>
nnoremap <leader>k :wincmd k<cr>
nnoremap <leader>l :wincmd l<cr>

nnoremap <leader>s :term<cr>

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

let g:LanguageClient_autoStart = 1
" We don't want our quickfix list always spammed with diagnostics
let g:LanguageClient_diagnosticsList = 'Disabled'

" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

nnoremap <leader>d :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>rn :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>z :call LanguageClient_contextMenu()<CR>

let g:LanguageClient_serverCommands = {
      \ 'rust': ['rls'],
      \ 'python': ['pyls'],
      \ 'cpp': ['clangd'],
      \ 'c': ['clangd'],
      \ 'groovy': ['groovy-language-server'],
      \ 'java': ['eclipse-jdt-ls']
      \ }

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

nnoremap <leader>f :Files<cr>
nnoremap <leader>L :Lines<cr>
nnoremap <leader>H :History<cr>

" ---------------------------------------------------------- RAINBOW

let g:rainbow_active = 1

" --------------------------------------------------------- GIT GUTTER

set updatetime=100

" ------------------------------------------------------- NERD COMMENTER

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" --------------------------------------------------------- MUCOMPLETE

" Mandatory options for plugin to work
set completeopt+=menuone
set completeopt+=noselect
" Shut off completion messages
set shortmess+=c
" prevent a condition where vim lags due to searching include files.
set complete-=i
let g:mucomplete#enable_auto_at_startup = 1
" :help mucomplete#chains for more details
let g:mucomplete#chains = {}
let g:mucomplete#chains.default  = ['path', 'omni', 'keyn', 'dict', 'uspl', 'ulti']
let g:mucomplete#chains.markdown = ['path', 'keyn', 'dict', 'uspl']
let g:mucomplete#chains.vim      = ['path', 'keyn', 'dict', 'uspl']
