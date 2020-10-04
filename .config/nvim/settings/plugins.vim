call plug#begin("~/.config/nvim/plugged")

" Good Looking Status Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Auto Format
Plug 'chiel92/vim-autoformat'

" Auto Pairs
Plug 'jiangmiao/auto-pairs'

" Automatic Window Resizing
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" All the colorschemes you need
Plug 'flazz/vim-colorschemes'

" Fuzzy Finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Language Pack
Plug 'sheerun/vim-polyglot'

" Nerd Tree
Plug 'preservim/nerdtree'

" Ranger Integration
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

" Fancy Start Screen
Plug 'mhinz/vim-startify'

" Show Added, Changed, And Deleted Lines With Git
Plug 'airblade/vim-gitgutter'

" Debugging
Plug 'puremourning/vimspector'

call plug#end()
