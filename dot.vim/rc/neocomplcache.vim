set complete& complete+=k
set completeopt& completeopt+=menuone completeopt-=preview
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_complete_start_length = 2
let g:neocomplcache_enable_smart_case = 1
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns.tmux = '\h[0-9A-Za-z-]*'
let g:neocomplcache_keyword_patterns.copl = '\<\a[[:alnum:]-]*'
if !exists('g:neocomplcache_dictionary_filetype_lists')
  let g:neocomplcache_dictionary_filetype_lists = {}
endif
let g:neocomplcache_dictionary_filetype_lists.java = expand('~/.vim/dict/java.dict')
imap <expr> <C-v> <SID>c_v()
function! s:c_v()
  if neosnippet#expandable_or_jumpable()
    return "\<Plug>(neosnippet_expand_or_jump)"
  else
    return neocomplcache#complete_common_string()
  endif
endfunction

inoremap <expr> <C-h> neocomplcache#smart_close_popup() . "\<C-h>"
inoremap <expr> <C-x><C-f> neocomplcache#manual_filename_complete()
