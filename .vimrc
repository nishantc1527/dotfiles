" {{{ MAPPINGS }}}

  " {{{ LEADER KEY }}}

    let mapleader = " "

  " {{{ INSERT MODE }}}

    inoremap jk <esc>
    inoremap <esc> <nop>
    inoremap <up> <nop>
    inoremap <down> <nop>
    inoremap <left> <nop>
    inoremap <right> <nop>
    inoremap <c-j> <esc>ja
    inoremap <c-k> <esc>ka

  " {{{ NORMAL MODE }}}

    nnoremap <leader>ev :e $MYVIMRC<cr>
    nnoremap <leader>s :FloatermToggle<cr>
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

  " {{{ VISUAL MODE }}}

    vnoremap < <gv
    vnoremap > >gv
    vnoremap <leader>s :sort<cr>

  " {{{ TERMINAL MODE }}}

    tnoremap jk <c-\><c-n>:FloatermToggle<cr>

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

  " {{{ PRODUCTIVITY }}}

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

  call plug#end()
" {{{ PLUGIN CONFIGURATION }}}

  " {{{ AIRLINE }}}
    
    " Set The Airline Theme
    let g:airline_theme = "dracula"

    " Use Powerline Fonts
    let g:airline_powerline_fonts = 1

    " Initialize Airline Symbols
    if !exists('g:airline_symbols')
          let g:airline_symbols = {}
    endif

    " Unicode Symbols
    let g:airline_left_sep = '»'
    let g:airline_left_sep = '▶'
    let g:airline_right_sep = '«'
    let g:airline_right_sep = '◀'
    let g:airline_symbols.linenr = '␊'
    let g:airline_symbols.linenr = '␤'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.paste = 'Þ'
    let g:airline_symbols.paste = '∥'
    let g:airline_symbols.whitespace = 'Ξ'

    " Airline Symbols
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''

    " Configure The Tabline
    let g:airline#extensions#tmuxline#enabled = 0
    let g:airline#extensions#neomake#enabled = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_buffers = 1 " enable/disable displaying buffers with a single tab
    let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
    let g:airline#extensions#tabline#formatter = 'unique_tail'
    let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
    let g:airline#extensions#tagbar#enabled = 0

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

  " {{{ CLOSETAG }}}

    let g:closetag_filenames = '*.xml'
    let g:closetag_xhtml_filenames = '*.xml'
    let g:closetag_filetypes = 'xml'
    let g:closetag_xhtml_filetypes = 'xml'

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

    " Use <c-space> to trigger completion.
    if has('nvim')
      inoremap <silent><expr> <c-space> coc#refresh()
    else
      inoremap <silent><expr> <c-@> coc#refresh()
    endif

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
    if exists('*complete_info')
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> <leader>ld <Plug>(coc-definition)
    nmap <silent> <leader>lr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> <leader>k :call <SID>show_documentation()<CR>
    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocActionAsync('doHover')
      endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nnoremap <silent> <leader>rn <Plug>(coc-rename)
    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json,java setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac  <Plug>(coc-codeaction)

    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap <leader>if <Plug>(coc-funcobj-i)
    omap <leader>if <Plug>(coc-funcobj-i)
    xmap <leader>af <Plug>(coc-funcobj-a)
    omap <leader>af <Plug>(coc-funcobj-a)
    xmap <leader>ic <Plug>(coc-classobj-i)
    omap <leader>ic <Plug>(coc-classobj-i)
    xmap <leader>ac <Plug>(coc-classobj-a)
    omap <leader>ac <Plug>(coc-classobj-a)

    " Use CTRL-S for selections ranges.
    " Requires 'textDocument/selectionRange' support of language server.
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Mappings for CoCList
    " Show all diagnostics.
    nnoremap <silent><nowait> ,a  :<C-u>CocList diagnostics<cr>

    " Manage extensions.
    nnoremap <silent><nowait> ,e  :<C-u>CocList extensions<cr>

    " Show commands.
    nnoremap <silent><nowait> ,c  :<C-u>CocList commands<cr>

    " Find symbol of current document.
    nnoremap <silent><nowait> ,o  :<C-u>CocList outline<cr>

    " Search workspace symbols.
    nnoremap <silent><nowait> ,s  :<C-u>CocList -I symbols<cr>

    " Do default action for next item.
    nnoremap <silent><nowait> ,j  :<C-u>CocNext<CR>

    " Do default action for previous item.
    nnoremap <silent><nowait> ,k  :<C-u>CocPrev<CR>

    " Resume latest coc list.
    nnoremap <silent><nowait> ,p  :<C-u>CocListResume<CR>
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
    nnoremap <m-cr> :CocCommand actions.open<cr>

  " {{{ FUGITIVE }}}

    nnoremap <leader>gs :G<cr>
    nnoremap <leader>gl :GV<cr>
    nnoremap <leader>gd :Gdiffsplit<cr>
    nnoremap <leader>gf :diffget //2<cr>
    nnoremap <leader>gj :diffget //3<cr>

  " {{{ FZF }}}

    nnoremap <leader>F :Files<cr>
    nnoremap <leader>B :Buffers<cr>

  " {{{ INDENT LINE }}}
  "
    let g:indentLine_color_term = 6
    let g:indentLine_char_list = ['|', '¦', '┆', '┊']
    let g:indentLine_setConceal = 1
    let g:indentLine_conceallevel = 1
    let g:indentLine_concealcursor = ""

  " {{{ RANGER }}}

    let g:ranger_replace_netrw = 1

  " {{{ RUFO }}}

    let g:rufo_auto_formatting = 1

  " {{{ TAGBAR }}}

    nnoremap <leader>p :TagbarToggle<cr>

  " {{{ ULTISNIPS }}}

    let g:UltiSnipsExpandTrigger="<c-j>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    let g:UltiSnipsEditSplit="vertical"

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

" {{{ GENERAL SETTINGS }}}

  colorscheme dracula
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  set autoindent
  set background=dark
  set clipboard=unnamedplus
  set cmdheight=2
  set encoding=utf-8
  set expandtab
  set fileencoding=utf-8
  set formatoptions-=cro
  set hidden
  set incsearch
  set iskeyword+=-
  set nobackup
  set nohlsearch
  set noicon
  set noswapfile
  set notitle
  set nowrap
  set nowritebackup
  set pumheight=10
  set relativenumber number
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
