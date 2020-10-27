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

" Linting
Plug 'dense-analysis/ale'

" Comment Stuff
Plug 'tpope/vim-commentary'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Fast Finding
Plug 'unblevable/quick-scope'

" Dracula Colorscheme
Plug 'dracula/vim'

" Tag Finding
Plug 'preservim/tagbar'

" Indent Guides
Plug 'Yggdroot/indentLine'

" Low Distraction Mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Smooth Scrolling
Plug 'psliwka/vim-smoothie'

" This Colorscheme Is Pretty Awesome But I Don't Use It
Plug 'sainnhe/edge'

" Gradle Integration
Plug 'hdiniz/vim-gradle'

" Change Working Directory
Plug 'airblade/vim-rooter'

" Auto Formatter For Ruby
Plug 'ruby-formatter/rufo-vim'

" Change Surrounding Characters
Plug 'tpope/vim-surround'

" Vim Developement
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()
