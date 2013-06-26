" reverse lines
command! -range Reverse call <SID>reverse(<line1>, <line2>)

function! s:reverse(line1, line2)
  let l:rev = reverse(getline(a:line1, a:line2))
  for l:i in range(a:line1, a:line2)
    call setline(l:i, l:rev[l:i-a:line1])
  endfor
endfunction
