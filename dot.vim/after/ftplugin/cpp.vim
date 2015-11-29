setlocal path=.,/usr/local/include,/opt/local/include,/usr/include/c++/4.0.0,,

" errormaker.vim
"autocmd BufWritePost <buffer> call <SID>errormaker_cpp()
function! s:errormaker_cpp()
  let save_makeprg = &l:makeprg
  setlocal makeprg=g++\ -Wall\ -fsyntax-only\ %
  silent make
  "let &l:makeprg = save_makeprg
endfunction

let s:clang_format_plugin_path = get(g:, 'clang_format_plugin_path', '/usr/share/clang/clang-format.py')
if filereadable(s:clang_format_plugin_path)
  command! -buffer ClangFormat execute 'pyfile ' s:clang_format_plugin_path
  augroup cpp-clang-format
    autocmd!
    autocmd BufWritePre <buffer> ClangFormat
  augroup END
endif
