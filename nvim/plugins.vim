" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  echo 'Installing Vim Plug'
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'preservim/nerdtree'

Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/tagalong.vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'SirVer/ultisnips'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'alvan/vim-closetag'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
Plug 'chiel92/vim-autoformat'
Plug 'dense-analysis/ale'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'flazz/vim-colorschemes'
Plug 'floobits/floobits-neovim'
Plug 'godlygeek/tabular'
Plug 'hdima/python-syntax'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'luochen1990/rainbow'
Plug 'mattn/vim-goimports'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'plasticboy/vim-markdown'
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
Plug 'psliwka/vim-smoothie'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'rust-lang/rust.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'slim-template/vim-slim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tweekmonster/gofmt.vim'
Plug 'unblevable/quick-scope'
Plug 'valloric/matchtagalways'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/indentpython.vim'
Plug 'vim-scripts/matchit.zip'

call plug#end()
