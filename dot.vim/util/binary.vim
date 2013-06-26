augroup vimrc-util-binary
  autocmd!
  autocmd BufReadPost * call <SID>bufread_post()
  autocmd BufWritePre * call <SID>bufwrite_pre()
  autocmd BufWritePost * call <SID>bufwrite_post()
augroup END

function! s:bufread_post()
  if &l:binary
    silent %!xxd -g 1
    setlocal filetype=xxd
  endif
endfunction

function! s:bufwrite_pre()
  if &l:binary
    %!xxd -r
  endif
endfunction

function! s:bufwrite_post()
  if &l:binary
    silent %!xxd -g 1
    setlocal nomodified
  endif
endfunction
