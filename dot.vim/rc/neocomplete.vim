set complete& complete+=k
set completeopt& completeopt+=menuone completeopt-=preview
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns.tmux = '\h[0-9A-Za-z-]*'
let g:neocomplete#keyword_patterns.copl = '\<\a[[:alnum:]-]*'
imap <expr> <C-v> <SID>c_v()
function! s:c_v()
  if neosnippet#expandable_or_jumpable()
    return "\<Plug>(neosnippet_expand_or_jump)"
  else
    return neocomplete#complete_common_string()
  endif
endfunction

inoremap <expr> <C-h> neocomplete#smart_close_popup() . "\<C-h>"
inoremap <expr> <C-x><C-f> neocomplete#start_manual_complete(['file'])
inoremap <expr> <C-x><C-o> neocomplete#start_manual_complete()
