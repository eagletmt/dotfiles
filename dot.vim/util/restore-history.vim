augroup vimrc-util-restore-history
  autocmd!
  autocmd BufReadPost * call s:restore_history()
augroup END

function! s:restore_history()
  if line("'\"") > 0 && line("'\"") <= line("$")
    normal! g`"
    normal! zz
  endif
endfunction
