let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1

" Debugging
autocmd FileType go nnoremap <leader>bs :GoDebugStart<cr>
autocmd FileType go nnoremap <leader>bc :GoDebugContinue<cr>
autocmd FileType go nnoremap <leader>bn :GoDebugNext<cr>
autocmd FileType go nnoremap <leader>bq :GoDebugStop<cr>
autocmd FileType go nnoremap <leader>bb :GoDebugBreakpoint<cr>
autocmd FileType go nnoremap <leader>bi :GoDebugStep<cr>
autocmd FileType go nnoremap <leader>bo :GoDebugStepOut<cr>
