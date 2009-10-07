nnoremap <buffer> <Space>* :<C-u>execute 'Wwwsearch -hoogle '.expand('<cword>')<CR>
nnoremap <buffer> <Space>h :<C-u>Wwwsearch -hoogle 
nnoremap <buffer> <silent> <Space>t :<C-u>call <SID>ShowType(expand('<cword>'))<CR>

function! s:ShowType(word)
  echo join(split(system("ghc -isrc " . expand('%') . " -e ':t " . a:word . "'")))
endfunction

