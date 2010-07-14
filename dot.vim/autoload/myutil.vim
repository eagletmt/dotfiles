function! myutil#warn(msg)  " {{{
  echohl WarningMsg
  echomsg a:msg
  echohl None
endfunction " }}}

function! myutil#map(expr, fn)  " {{{
  return map(deepcopy(a:expr), a:fn)
endfunction " }}}

function! myutil#synname(...) " {{{
  if a:0 == 0
    let line = line('.')
    let col = col('.')
  elseif a:0 == 2
    let line = a:1
    let col = a:2
  else
    throw 'invalid arguments'
  endif
  return synIDattr(synID(line, col, 0), 'name')
endfunction " }}}

function! myutil#cursor_char(...) " {{{
  if a:0 == 0
    let n = 0
    let mode = mode()
  elseif a:0 == 1
    let n = a:1
    let mode = mode()
  elseif a:0 == 2
    let n = a:1
    let mode = a:2
  else
    throw 'invalid arguments'
  endif

  if mode ==# 'c'
    let str = getcmdline()
    let col = getcmdpos()
  elseif mode =~# '^[inR]'
    let str = getline('.')
    let col = col('.')
    if mode !=# 'i'
      let n = n >= 0 ? n+1 : n-1
    endif
  else
    throw 'not supported mode: ' . mode
  endif

  if n >= 0
    return matchstr(str, '.', col-1, n)
  else
    let chars = split(str[0 : col-1], '\zs')
    if -n >= len(chars)
      return ''
    else
      return chars[n]
    endif
  endif
endfunction " }}}

function! myutil#strlen(str)  " {{{
  return strlen(substitute(a:str, '.', 'x', 'g'))
endfunction " }}}

function! myutil#substr(str, start, ...)  " {{{
  let s = strpart(a:str, byteidx(a:str, a:start))
  if a:0 == 0
    return s
  else
    let i = byteidx(s, a:1)
    return i == -1 ? s : strpart(s, 0, i)
  endif
endfunction " }}}

function! myutil#scan(expr, pat)  " {{{
  let ret = []
  let start = match(a:expr, a:pat)
  let end = 0
  while start >= 0
    call add(ret, matchlist(a:expr, a:pat, start))
    let start = match(a:expr, a:pat, end)
    let end = matchend(a:expr, a:pat, end)
  endwhile
  return ret
endfunction " }}}

" vim: set sw=2 ts=2 sts=2 et fdm=marker:

