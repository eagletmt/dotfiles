function! s:smart_backslash(line, l, c)
  for id in synstack(a:l, a:c)
    if synIDattr(id, 'name') =~? 'string'
      return '\'
    endif
  endfor
  return 'function('
endfunction

inoremap <buffer> <expr> \ <SID>smart_backslash(getline('.'), line('.'), col('.')-1)

