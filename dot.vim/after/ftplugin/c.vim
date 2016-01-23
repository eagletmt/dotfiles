let s:clang_format_plugin_path = get(g:, 'clang_format_plugin_path', '/usr/share/clang/clang-format.py')
if filereadable(s:clang_format_plugin_path)
  command! -buffer ClangFormat execute 'pyfile ' s:clang_format_plugin_path
  augroup c-clang-format
    autocmd!
    autocmd BufWritePre <buffer> ClangFormat
  augroup END
endif
