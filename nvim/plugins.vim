" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  echo 'Installing Vim Plug'
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'AndrewRadev/tagalong.vim'
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'alvan/vim-closetag'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
Plug 'dense-analysis/ale'
Plug 'flazz/vim-colorschemes'
Plug 'floobits/floobits-neovim'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'luochen1990/rainbow'
Plug 'mattn/vim-goimports'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'psliwka/vim-smoothie'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tweekmonster/gofmt.vim'
Plug 'unblevable/quick-scope'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-scripts/matchit.zip'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'vim-scripts/indentpython.vim'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-surround'
Plug 'chiel92/vim-autoformat'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()
