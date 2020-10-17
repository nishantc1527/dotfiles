call plug#begin("~/.config/nvim/plugged")

" Good Looking Status Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Auto Pairs
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'

" Automatic Window Resizing
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'

" Language Server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy Finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Language Pack
Plug 'sheerun/vim-polyglot'

" Ranger Integration
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

" Fancy Start Screen
Plug 'mhinz/vim-startify'

" Git Integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Debugging
Plug 'puremourning/vimspector'

" Linting
Plug 'dense-analysis/ale'

" Comment Stuff
Plug 'tpope/vim-commentary'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Fast Finding
Plug 'unblevable/quick-scope'

" Floating Terminal
Plug 'voldikss/vim-floaterm'

" Colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'drewtempelmeyer/palenight.vim'

call plug#end()
