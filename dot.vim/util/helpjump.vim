" original: http://d.hatena.ne.jp/mFumi/20100612/1276355084
augroup vimrc-util-helpjump
  autocmd!
  autocmd FileType help call <SID>do_mappings()
augroup END

function! s:do_mappings()
  nnoremap <buffer> <CR> <C-]>
  nnoremap <buffer> <silent> <Tab> :<C-u>call <SID>find_next_help_tagjump('W')<CR>
  nnoremap <buffer> <silent> <S-Tab> :<C-u>call <SID>find_next_help_tagjump('bW')<CR>
endfunction

function! s:find_next_help_tagjump(flag)
  let orig_view = winsaveview()
  let helpHyperTextJump = '\\\@<!|[^"*|]\+|'
  let helpOption1 = "'[a-z]\\{2,\\}'"
  let helpOption2 = "'t_..'"
  let regex = join([helpHyperTextJump, helpOption1, helpOption2], '\|')
  while search(regex, a:flag) > 0
    if synIDattr(synID(line('.'), col('.'), 0), 'name') =~# '^\(helpBar\|helpOption\)$'
      return
    endif
  endwhile
  call winrestview(orig_view)
endfunction
