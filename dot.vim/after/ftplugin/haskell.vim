nnoremap <buffer> <Space>* :<C-u>execute 'Wwwsearch -hoogle '.expand('<cword>')<CR>
nnoremap <buffer> <Space>h :<C-u>Wwwsearch -hoogle 
nnoremap <buffer> <silent> <Space>t :<C-u>call <SID>ShowType(expand('<cword>'))<CR>

function! s:ShowType(word)
  echo join(split(system("ghc -isrc " . expand('%') . " -e ':t " . a:word . "'")))
endfunction

vnoremap <buffer> zf :call <SID>fold_haskell()<CR>
function! s:fold_haskell() range
  let str = getline(a:firstline)
  if empty(str) || str =~# '\s$'
    call setline(a:firstline, str . '-- {{{')
  else
    call setline(a:firstline, str . ' -- {{{')
  endif

  let str = getline(a:lastline)
  if str =~# '^\s*$'
    call append(a:lastline-1, '-- }}}')
  elseif str =~# '\s$'
    call setline(a:lastline, str . '-- }}}')
  else
    call setline(a:lastline, str . ' -- }}}')
  endif
endfunction

setlocal cursorcolumn
setlocal omnifunc=necoghc#omnifunc
