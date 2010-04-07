function! s:encodeURIComponent(str)
  let s = ''
  for i in range(strlen(a:str))
    let c = a:str[i]
    if c =~# "[A-Za-z0-9-_.!~*'()]"
      let s .= c
    else
      let s .= printf('%%%02X', char2nr(a:str[i]))
    endif
  endfor
  return s
endfunction

function! s:decodeURIComponent(str)
  " FIXME:
  return substitute(a:str, '%\(\x\{2\}\)', "\\=eval('\"\\x' . submatch(1) . '\"')", 'g')
endfunction

function! s:encodeJSString(str)
  let s = ''
  for c in split(a:str, '\zs')
    if char2nr(c) < 0x80
      let s .= c
    else
      let s .= printf('\u%04x', char2nr(c))
    endif
  endfor
  return s
endfunction

function! s:decodeJSString(str)
  return substitute(a:str, '\\u\(\x\{4\}\)', '\=nr2char(str2nr(submatch(1), 16))', 'g')
endfunction

function! s:select(type)
  if a:type == 'char'
    silent normal! `[v`]
  elseif a:type == 'line'
    silent normal! '[V']
  elseif a:type == 'block'
    silent normal! `[\<C-v>`]
  else
    silent execute 'normal! `<' . a:type . '`>'
  endif
endfunction

function! s:op_encodeURIComponent(type)
  let sel_save = &selection
  let &selection = 'inclusive'
  let reg_save = @@

  call s:select(a:type)
  silent execute "normal! c\<C-r>=<SID>encodeURIComponent(@@)\<Esc>"

  let &selection = sel_save
  let @@ = reg_save
endfunction

function! s:op_decodeURIComponent(type)
  let sel_save = &selection
  let &selection = 'inclusive'
  let reg_save = @@

  call s:select(a:type)
  silent execute "normal! c\<C-r>=<SID>decodeURIComponent(@@)\<Esc>"

  let &selection = sel_save
  let @@ = reg_save
endfunction

function! s:op_encodeJSString(type)
  let sel_save = &selection
  let &selection = 'inclusive'
  let reg_save = @@

  call s:select(a:type)
  silent execute "normal! c\<C-r>=<SID>encodeJSString(@@)\<Esc>"

  let &selection = sel_save
  let @@ = reg_save
endfunction

function! s:op_decodeJSString(type)
  let sel_save = &selection
  let &selection = 'inclusive'
  let reg_save = @@

  call s:select(a:type)
  silent execute "normal! c\<C-r>=<SID>decodeJSString(@@)\<Esc>"

  let &selection = sel_save
  let @@ = reg_save
endfunction

nnoremap <silent> <Plug>encodeURIComponent :<C-u>set opfunc=<SID>op_encodeURIComponent<CR>g@
vnoremap <silent> <Plug>encodeURIComponent :<C-u>call <SID>op_encodeURIComponent(visualmode())<CR>
nnoremap <silent> <Plug>decodeURIComponent :<C-u>set opfunc=<SID>op_decodeURIComponent<CR>g@
vnoremap <silent> <Plug>decodeURIComponent :<C-u>call <SID>op_decodeURIComponent(visualmode())<CR>
nnoremap <silent> <Plug>encodeJSString :<C-u>set opfunc=<SID>op_encodeJSString<CR>g@
vnoremap <silent> <Plug>encodeJSString :<C-u>call <SID>op_encodeJSString(visualmode())<CR>
nnoremap <silent> <Plug>decodeJSString :<C-u>set opfunc=<SID>op_decodeJSString<CR>g@
vnoremap <silent> <Plug>decodeJSString :<C-u>call <SID>op_decodeJSString(visualmode())<CR>

