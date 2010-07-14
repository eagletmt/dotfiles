inoremap <buffer> <expr> ( <SID>in_tex_math() ? '\left(' : '('
inoremap <buffer> <expr> ) <SID>in_tex_math() ? '\right)' : ')'
function! s:in_tex_math()
  let x = synIDattr(synID(line('.'), col('.'), 0), 'name')
  let y = synIDattr(synID(line('.'), col('.')-1, 0), 'name')
  if x =~# '^texMath'
    return 1
  elseif x ==# 'Delimiter' || empty(x)
    return y ==# 'Delimiter' || y =~# '^texMath'
  else
    return 0
  endif
endfunction

