" {{{ MAPPINGS }}}

  " {{{ LEADER KEY }}}

    let mapleader = " "

  " {{{ LEADER KEY END }}}

  " {{{ INSERT MODE }}}

    inoremap jk <esc>
    inoremap <up> <nop>
    inoremap <down> <nop>
    inoremap <left> <nop>
    inoremap <right> <nop>

  " {{{ INSERT MODE END }}}

  " {{{ NORMAL MODE }}}

    nnoremap <leader>ev :e $MYVIMRC<cr>
    nnoremap <leader>h <c-w>h
    nnoremap <leader>j <c-w>j
    nnoremap <leader>k <c-w>k
    nnoremap <leader>l <c-w>l
    nnoremap <c-o> o<esc>
    nnoremap <tab> :bnext<cr>
    nnoremap <s-tab> :bprevious<cr>
    nnoremap <leader>q :Bclose<cr>

  " {{{ NORMAL MODE END }}}

  " {{{ VISUAL MODE }}}

    vnoremap < <gv
    vnoremap > >gv
    vnoremap <leader>s :sort<cr>

  " {{{ VISUAL MODE END }}}

" {{{ PLUGINS }}}

  call plug#begin("~/.config/nvim/plugged")
    
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/echodoc.vim'
    Plug 'SirVer/ultisnips'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'Yggdroot/indentLine'
    Plug 'airblade/vim-gitgutter'
    Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
    Plug 'dense-analysis/ale'
    Plug 'dracula/vim'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'francoiscabrol/ranger.vim'
    Plug 'hdiniz/vim-gradle'
    Plug 'honza/vim-snippets'
    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'luochen1990/rainbow'
    Plug 'mhinz/vim-startify'
    Plug 'preservim/nerdtree'
    Plug 'rbgrouleff/bclose.vim'
    Plug 'ruby-formatter/rufo-vim'
    Plug 'rust-lang/rust.vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'sheerun/vim-polyglot'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'unblevable/quick-scope'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'voldikss/vim-floaterm'

  " {{{ PRODUCTIVITY END }}}

  call plug#end()

" {{{ PLUGINS END }}}

" {{{ PLUG CONFIG }}}

  " {{{ QUICKSCOPE }}}

    let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

  " {{{ QUICKSCOPE END }}}

  " {{{ GOYO }}}
    
    nnoremap <leader>d :Goyo<cr>:Limelight!!<cr>

  " {{{ GOYO END }}}

  " {{{ LSP }}}

    let g:LanguageClient_autoStart = 1

    let g:LanguageClient_serverCommands = {
      \ 'rust': ['rls'],
      \ 'java': ['jdtls', '-data', getcwd()],
      \ 'go': ['gopls'],
      \ 'sh': ['bash-language-server', 'start']
      \ }

    nnoremap <leader>ld :call LanguageClient#textDocument_definition()<cr>
    nnoremap <leader>lr :call LanguageClient#textDocument_rename()<cr>
    nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<cr>
    nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<cr>
    nnoremap <leader>lx :call LanguageClient#textDocument_references()<cr>
    nnoremap <leader>lc :call LanguageClient#textDocument_completion()<cr>
    nnoremap <leader>lh :call LanguageClient#textDocument_hover()<cr>
    nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<cr>
    nnoremap <leader>lm :call LanguageClient_contextMenu()<cr>
    nnoremap <leader>la :call LanguageClient_textDocument_codeAction()<cr>

    let g:echodoc#enable_at_startup = 1
    let g:echodoc#type = 'signature'

    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    let g:deoplete#enable_at_startup = 1
    inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
    inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<tab>"
    inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<cr>"
    set completeopt+=noselect,menuone,preview

  " {{{ LSP END }}}

  " {{{ ALE }}}

    let g:ale_echo_msg_error_str = 'E'		
    let g:ale_echo_msg_warning_str = 'W'		
    let g:ale_sign_error = '✘'		
    let g:ale_sign_warning = '⚠'		

    let g:ale_open_list = 0		
    let g:ale_loclist = 0		

    let g:ale_linters = {		
          \  'python': ['pylint'],		
          \  'java': ['javac'],		
          \ 'sh': ['shellcheck'],		
          \ 'cpp': ['clang', 'gcc'],		
          \ 'rust': ['cargo', 'rustc', 'rustfmt']		
          \ }	

  " {{{ ALE END }}}

  " {{{ NERD TREE }}}

    let g:NERDTreeGitStatusUseNerdFonts = 1
    let g:NERDTreeGitStatusShowIgnored = 1
    nnoremap <leader>t :NERDTreeToggle<cr>

  " {{{ NERD TREE END }}}
  
  " {{{ AIRLINE }}}
    
    let g:airline_theme = "dracula"
    let g:airline_powerline_fonts = 1

    if !exists('g:airline_symbols')
          let g:airline_symbols = {}
    endif

    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.paste = '∥'
    let g:airline_symbols.whitespace = 'Ξ'
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ')'
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = '('
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''
    let g:airline#extensions#tmuxline#enabled = 0
    let g:airline#extensions#neomake#enabled = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_buffers = 1
    let g:airline#extensions#tabline#tab_nr_type = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail'
    let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
    let g:airline#extensions#tagbar#enabled = 0

  " {{{ AIRLINE END }}}

  " {{{ FUGITIVE }}}

    nnoremap <leader>gs :G<cr>
    nnoremap <leader>gl :GV<cr>
    nnoremap <leader>gd :Gdiffsplit<cr>
    nnoremap <leader>gf :diffget //2<cr>
    nnoremap <leader>gj :diffget //3<cr>

  " {{{ FUGITIVE END }}}

  " {{{ FZF }}}

    nnoremap / :BLines<cr>
    nnoremap <c-p> :Files<cr>

  " {{{ FZF END }}}

  " {{{ INDENT LINE }}}

    let g:indentLine_color_term = 6
    let g:indentLine_char_list = ['|', '¦', '┆', '┊']
    let g:indentLine_setConceal = 1
    let g:indentLine_conceallevel = 1
    let g:indentLine_concealcursor = ""

  " {{{ INDENT LINE END }}}

  " {{{ RANGER }}}

    let g:ranger_replace_netrw = 1

  " {{{ RANGER END }}}

  " {{{ RUFO }}}

    let g:rufo_auto_formatting = 1

  " {{{ RUFO END }}}

  " {{{ TAGBAR }}}

    nnoremap <leader>p :TagbarToggle<cr>

  " {{{ TAGBAR END }}}

  " {{{ ULTISNIPS }}}

    imap <c-u> <Plug>(ultisnips_expand)
    let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
    let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
    let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
    let g:UltiSnipsRemoveSelectModeMappings = 0

  " {{{ ULTISNIPS END }}}

  " {{{ VIM GO }}}

    let g:go_fmt_command = "goimports"
    let g:go_auto_type_info = 1

    augroup debugging
          autocmd!
          autocmd FileType go nnoremap <leader>bs :GoDebugStart<cr>
          autocmd FileType go nnoremap <leader>bc :GoDebugContinue<cr>
          autocmd FileType go nnoremap <leader>bn :GoDebugNext<cr>
          autocmd FileType go nnoremap <leader>bq :GoDebugStop<cr>
          autocmd FileType go nnoremap <leader>bb :GoDebugBreakpoint<cr>
          autocmd FileType go nnoremap <leader>bi :GoDebugStep<cr>
          autocmd FileType go nnoremap <leader>bo :GoDebugStepOut<cr>
    augroup END

  " {{{ VIM GO END }}}

  " {{{ RAINBOW }}}

    let g:rainbow_active = 1

  " {{{ RAINBOW END }}}

" {{{ PLUG CONFIG END }}}

" {{{ GENERAL SETTINGS }}}

  autocmd CursorMoved * normal zz
  colorscheme dracula " Dracula coloscheme is awesome
  filetype plugin indent on
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " Enable true color
  set autoindent " Automatically indent
  set background=dark " Set dark background
  set clipboard=unnamedplus " Copy and paste into other programs
  set cmdheight=2
  set encoding=utf-8 " Set encoding as utf8
  set expandtab " Change tabs to spaces
  set fileencoding=utf-8 " Set file encoding as utf8
  set formatoptions-=cro
  set hidden
  set incsearch " Incremental search
  set iskeyword+=-
  set nobackup
  set nohlsearch
  set noicon
  set noswapfile
  set notitle
  set nowrap " Don't wrap lines
  set nowritebackup
  set pumheight=10
  set relativenumber number " Relative line numbers
  set shiftwidth=2
  set shortmess+=c
  set showtabline=2
  set signcolumn=yes
  set smartindent
  set smarttab
  set splitright
  set t_Co=256
  set tabstop=2 softtabstop=2
  set termguicolors
  set timeoutlen=500
  set undodir=~/.config/nvim/undo
  set undofile
  set updatetime=100
  syntax enable " Enable syntax highlighting

" {{{ GENERAL SETTINGS END }}}

" {{{ CREATE TERMINALS }}}

  function SpringTerms()
    execute "FloatermNew --name=sql mysql -u root -p"
    execute "FloatermHide"

    nnoremap <leader>s :FloatermShow sql<cr>
    tnoremap <c-t> <c-\><c-n>:FloatermToggle<cr>

    execute "FloatermNew --name=run"
    execute "FloatermHide"
    nnoremap <leader>r :FloatermSend --name=run ./gradlew bootRun<cr>:FloatermShow run<cr>
  endfunction

  function GradeTerms()
    execute "FloatermNew"
    execute "FloatermHide"
    nnoremap <leader>s :FloatermSend ./gradlew build<cr>:FloatermShow<cr>
  endfunction
 
" {{{ CREATE TERMINALS END }}}
