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
    inoremap <c-j> <esc>ja
    inoremap <c-k> <esc>ka

  " {{{ INSERT MODE END }}}

  " {{{ NORMAL MODE }}}

    nnoremap <leader>ev :e $MYVIMRC<cr>
    nnoremap <leader>h <c-w>h
    nnoremap <leader>j <c-w>j
    nnoremap <leader>k <c-w>k
    nnoremap <leader>l <c-w>l
    nnoremap <c-o> o<esc>
    nnoremap / :Lines<cr>
    nnoremap <tab> :bnext<cr>
    nnoremap <s-tab> :bprevious<cr>
    nnoremap <leader>q :Bclose<cr>
    nnoremap <leader>d :Goyo<cr>:Limelight!!<cr>

  " {{{ NORMAL MODE END }}}

  " {{{ VISUAL MODE }}}

    vnoremap < <gv
    vnoremap > >gv
    vnoremap <leader>s :sort<cr>

  " {{{ VISUAL MODE END }}}

" {{{ PLUGINS }}}

  call plug#begin("~/.config/nvim/plugged")

  " {{{ AESTHETICS }}}

    " Good Looking Status Line
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Fancy Start Screen
    Plug 'mhinz/vim-startify'

    " Other Colorschemes
    Plug 'sainnhe/edge'
    Plug 'sainnhe/forest-night'

    " Indent Guides
    Plug 'Yggdroot/indentLine'

    " Dracula Colorscheme
    Plug 'dracula/vim'

    " Dev Icons
    Plug 'ryanoasis/vim-devicons'

  " {{{ AESTHETICS END }}}

  " {{{ PRODUCTIVITY }}}

    " Linting
    Plug 'vim-syntastic/syntastic'

    " Rust Developement
    Plug 'rust-lang/rust.vim'

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

    " Nerd Tree
    Plug 'preservim/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

    " Git Integration
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " Comment Stuff
    Plug 'tpope/vim-commentary'

    " Snippets
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    " Better Finding
    Plug 'unblevable/quick-scope'
    Plug 'rhysd/clever-f.vim'

    " Tag Finding
    Plug 'preservim/tagbar'

    " Low Distraction Mode
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'

    " Smooth Scrolling
    Plug 'psliwka/vim-smoothie'

    " Gradle Integration
    Plug 'hdiniz/vim-gradle'

    " Auto Formatter For Ruby
    Plug 'ruby-formatter/rufo-vim'

    " Change Surrounding Characters
    Plug 'tpope/vim-surround'

    " Go Developement
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

    " Floating Terminal
    Plug 'voldikss/vim-floaterm'

    " Rainbow Brackets
    Plug 'luochen1990/rainbow'

  " {{{ PRODUCTIVITY END }}}

  call plug#end()

" {{{ PLUGINS END }}}

" {{{ PLUG CONFIG }}}

  " {{{ SYNTASTIC }}}

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    let g:syntastic_java_checkers=['javac']
    let g:syntastic_java_javac_config_file_enabled = 1

  " {{{ SYNTASTIC END }}}

  " {{{ NERD TREE }}}

    nnoremap <leader>t :NERDTreeToggle<cr>

  " {{{ NERD TREE END }}}
  
  " {{{ AIRLINE }}}
    
    " Set The Airline Theme
    let g:airline_theme = "dracula"

    " Use Powerline Fonts
    let g:airline_powerline_fonts = 1

    " Initialize Airline Symbols
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
    let g:airline#extensions#tabline#show_buffers = 1 " enable/disable displaying buffers with a single tab
    let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
    let g:airline#extensions#tabline#formatter = 'unique_tail'
    let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
    let g:airline#extensions#tagbar#enabled = 0

  " {{{ AIRLINE END }}}

  " {{{ CLOSETAG }}}

    let g:closetag_filenames = '*.xml'
    let g:closetag_xhtml_filenames = '*.xml'
    let g:closetag_filetypes = 'xml'
    let g:closetag_xhtml_filetypes = 'xml'

  " {{{ CLOSETAG END }}}

  " {{{ COC }}}

    inoremap <silent><expr> <Tab>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<Tab>" :
          \ coc#refresh()

    " use <tab> for trigger completion and navigate to the next complete item
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
    if exists('*complete_info')
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " Use `[` and `]` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> [ <Plug>(coc-diagnostic-prev)
    nmap <silent> ] <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> <leader>ld <Plug>(coc-definition)
    nmap <silent> <leader>lr <Plug>(coc-references)

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json,java setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

    nnoremap <m-cr> :CocAction<cr>

  " {{{ COC END }}}

  " {{{ FUGITIVE }}}

    nnoremap <leader>gs :G<cr>
    nnoremap <leader>gl :GV<cr>
    nnoremap <leader>gd :Gdiffsplit<cr>
    nnoremap <leader>gf :diffget //2<cr>
    nnoremap <leader>gj :diffget //3<cr>

  " {{{ FUGITIVE END }}}

  " {{{ FZF }}}

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

    let g:UltiSnipsExpandTrigger="<c-j>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    let g:UltiSnipsEditSplit="vertical"

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
  set relativenumber number " Relative Line Numbers
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
  syntax enable

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
