command! -nargs=? -range=% SudoWrite call <SID>sudo_write(<q-args>, <line1>, <line2>)

function! s:sudo_write(path, line1, line2)
  if empty(a:path)
    let path = expand('%')
  else
    let path = a:path
  endif
  silent execute 'write !sudo tee >/dev/null ' . path
  setlocal nomodified
endfunction
