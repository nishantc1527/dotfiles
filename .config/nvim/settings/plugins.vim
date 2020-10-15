call plug#begin("~/.config/nvim/plugged")

" Good Looking Status Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Auto Format
Plug 'chiel92/vim-autoformat'

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

" Nerd Plugins
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'artanikin/vim-synthwave84'
Plug 'bluz71/vim-moonfly-colors'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'connorholyday/vim-snazzy'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'glepnir/oceanic-material'
Plug 'jaredgorski/spacecamp'
Plug 'sainnhe/forest-night'
Plug 'tomasiser/vim-code-dark'
Plug 'whatyouhide/vim-gotham'
Plug 'haishanh/night-owl.vim'
Plug 'fenetikm/falcon'
Plug 'sainnhe/sonokai'
Plug 'joshdick/onedark.vim'
Plug 'relastle/bluewery.vim'

call plug#end()
