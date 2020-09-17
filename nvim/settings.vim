let mapleader = " "

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
set noswapfile
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
set updatetime=300                      " Faster completion
syntax enable                           " Enables syntax highlighing
set notitle
set noicon

colorscheme palenight

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC

autocmd BufEnter * silent! lcd %:p:h
