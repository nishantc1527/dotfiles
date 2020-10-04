set autoindent                          " Good auto indent
set background=dark                     " tell vim what the background color looks like
set clipboard=unnamedplus               " Copy paste between vim and everything else
set cmdheight=2                         " More space for displaying messages
set encoding=utf-8                      " The encoding displayed
set expandtab                           " Converts tabs to spaces
set fileencoding=utf-8                  " The encoding written to file
set formatoptions-=cro                  " Stop newline continution of comments
set hidden                              " Required to keep multiple buffers open multiple buffers
set incsearch
set iskeyword+=-                        " treat dash separated words as a word text object"
set nobackup
set nobackup                            " This is recommended by coc
set nohlsearch
set noicon
set noswapfile
set notitle
set nowrap                              " Display long lines as just one line
set nowritebackup                       " This is recommended by coc
set pumheight=10                        " Makes popup menu smaller
set relativenumber number               " Line numbers
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set shortmess+=c
set showtabline=2                       " Always show tabs
set smartindent                         " Makes indenting smart
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set tabstop=2 softtabstop=2             " Insert 2 spaces for a tab
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set undodir=~/.config/nvim/undo
set undofile
set updatetime=100                      " Faster completion
syntax enable                           " Enables syntax highlighing

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
