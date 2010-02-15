set columns=160 lines=40
if has('gui_macvim')
  set fuoptions=maxvert,maxhorz
  set transparency=10
  nnoremap ,f :<C-u>set invfullscreen<CR>
endif

colorscheme candy

" quickrun.vim
let g:quickrun_config['*'].runmode = 'async:remote:vimproc'

