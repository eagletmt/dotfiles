command! -nargs=1 -complete=command Capture call s:cmd_capture(<q-args>)

function! s:cmd_capture(cmd)
  redir => result
  silent execute a:cmd
  redir END

  let bufname = 'Capture: ' . a:cmd
  new
  setlocal buftype=nofile bufhidden=hide noswapfile
  silent file `=bufname`
  call setline(1, split(result))
endfunction
