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

" Additional Colorschemes
Plug 'sainnhe/forest-night'
Plug 'tomasiser/vim-code-dark'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'bluz71/vim-moonfly-colors'

" Nerd Plugins
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'

call plug#end()
