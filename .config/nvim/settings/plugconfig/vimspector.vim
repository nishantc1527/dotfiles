let g:vimspector_enable_mappings = 'HUMAN'

function! JavaStartDebugCallback(err, port)
      execute "cexpr! 'Java debug started on port: " . a:port . "'"
      call vimspector#LaunchWithSettings({ "configuration": "Java Attach", "AdapterPort": a:port })
endfunction

function JavaStartDebug()
      call CocActionAsync('runCommand', 'vscode.java.startDebugSession', function('JavaStartDebugCallback'))
endfunction

nnoremap <F1> :call JavaStartDebug()<CR>
