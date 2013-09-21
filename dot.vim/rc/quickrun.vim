nnoremap <silent> <Space>r :QuickRun -mode n<CR>
vnoremap <silent> <Space>r :QuickRun -mode v<CR>
let g:quickrun_config = {
      \ '_': {'split': 'rightbelow', 'exec': '%C %o %s %a'},
      \ 'lisp': {'command' : 'sbcl --script'},
      \ 'haskell': {'cmdopt': '-Wall -W -fno-warn-unused-do-bind'},
      \ 'c': {'cmdopt': '-pipe -Wall -W -lgmp'},
      \ 'matlab': {'command': 'octave -q'},
      \ 'd': {'command': 'dmd -run'},
      \ 'coq': {'command': 'coqc'},
      \ 'coffee': {'command': 'coffee', 'cmdopt': '-c -p'},
      \ 'markdown': { 'type': 'markdown/redcarpet' },
      \ }

let s:hook = {
      \ 'kind': 'hook',
      \ 'name': 'bundler',
      \ }

function! s:hook.on_module_loaded(session, context)
  if a:session.config.type !=# 'ruby'
    return
  endif
  if !executable('bundle')
    return
  endif

  let l:lines = split(system(printf('cd %s; ruby -rbundler/shared_helpers -e "puts Bundler::SharedHelpers.in_bundle?"', expand('%:h'))), '\n')
  if v:shell_error == 0 && !empty(l:lines) && filereadable(l:lines[0])
    let a:session.config.exec = 'env BUNDLE_GEMFILE=' . shellescape(l:lines[0]) . ' bundle exec %C %s'
  endif
endfunction

call quickrun#module#register(s:hook)
unlet s:hook
