setlocal path=.,/usr/local/include,/opt/local/include,/usr/include/c++/4.0.0,,

" errormaker.vim
autocmd BufWritePost <buffer> call <SID>errormaker_cpp()
function! s:errormaker_cpp()
  let save_makeprg = &l:makeprg
  setlocal makeprg=g++\ -Wall\ -fsyntax-only\ %
  silent make
  "let &l:makeprg = save_makeprg
endfunction

