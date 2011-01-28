"set columns=160 lines=40
set imdisable
set guioptions=erL

if has('gui_macvim')
  set fuoptions=maxvert,maxhorz
  set transparency=7
  nnoremap ,f :<C-u>set invfullscreen<CR>
elseif has('unix')
  set guifont=Inconsolata\ 12
  set guifontwide=MigMix\ 1P\ 11
endif

colorscheme xoria256

" quickrun.vim
if !exists('g:quickrun_config')
  let g:quickrun_config = {}
endif
if !has_key(g:quickrun_config, '_')
  let g:quickrun_config._ = {}
endif
let g:quickrun_config._.runmode = 'async:remote:vimproc'

