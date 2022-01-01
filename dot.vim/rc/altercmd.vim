call altercmd#define('ccd', 'cd %:h')
call altercmd#define('submit', 'OnlineJudgeSubmit')
call altercmd#define('test', 'OnlineJudgeTest')
call altercmd#define('man', 'Ref man')
call altercmd#define('gbl', 'Git blame')

if executable('ag')
  command! -nargs=+ AgGrep call s:ag_grep(<q-args>)
  function! s:ag_grep(qargs)
    let l:save_prg = &l:grepprg
    let &l:grepprg = 'ag -a'
    execute 'grep' a:qargs
    let &l:grepprg = l:save_prg
  endfunction
  call altercmd#define('ag', 'AgGrep')
endif
