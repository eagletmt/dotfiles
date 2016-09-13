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
