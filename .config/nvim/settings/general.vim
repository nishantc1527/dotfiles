set autoindent
set background=dark
set clipboard=unnamedplus
set cmdheight=2
set encoding=utf-8
set expandtab
set fileencoding=utf-8
set formatoptions-=cro
set hidden
set incsearch
set iskeyword+=-
set nobackup
set nohlsearch
set noicon
set noswapfile
set notitle
set nowrap
set nowritebackup
set pumheight=10
set relativenumber number
set shiftwidth=2
set shortmess+=c
set showtabline=2
set smartindent
set smarttab
set splitright
set t_Co=256
set tabstop=2 softtabstop=2
set timeoutlen=500
set undodir=~/.config/nvim/undo
set undofile
set updatetime=100
syntax enable

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

colorscheme matrix

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
