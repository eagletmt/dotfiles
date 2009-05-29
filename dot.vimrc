set nocompatible

syntax on
filetype plugin indent on

" visual
set ruler showcmd hlsearch background=dark title number
set laststatus=2 statusline=[%L]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.']'}%r%m%=%c:%l/%L

" encoding
set encoding=utf-8 termencoding=utf-8 fileencoding=utf-8 
set fileencodings=utf-8,euc-jp,cp932
set ambiwidth=double

" indent
set expandtab tabstop=2 shiftwidth=2 softtabstop=2 smarttab autoindent cindent

" edit
set backspace=indent,eol,start
set modeline modelines=5

" swap
set swapfile directory=~/.vim/swap

" backup
set backup writebackup backupcopy=yes backupdir=~/.vim/backup backupext=.bak

" restore edit history
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" edit binary
augroup Binary
  au!
  au BufReadPost * if &binary | silent %!xxd -g 1
  au BufReadPost * set ft=xxd | endif
  
  au BufWritePre * if &binary | %!xxd -r | endif
  au BufWritePost * if &binary | silent %!xxd -g 1
  au BufWritePost * set nomod | endif
augroup END

" * works well for Japanese
vnoremap * "zy:let @/ = @z<CR>n"

" *.m is objc
let g:filetype_m='objc'

let g:mapleader = ' '

" filetype
autocmd BufRead *.bf set ft=bf

