set nocompatible

runtime rc/plug.vim

syntax enable
filetype plugin indent on

set ruler showcmd notitle number
set laststatus=2
set statusline=%t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.']'}%r%m%=%c:%l/%L\ %#Cursor#%{fugitive#statusline()}%#StatusLine#
set foldmethod=marker
set listchars=eol:$,tab:>-

set encoding=utf-8 termencoding=utf-8 fileencoding=utf-8
set fileencodings=utf-8,euc-jp,cp932
set ambiwidth=double
set fileformats=unix,dos

set expandtab smarttab autoindent
set tabstop=8 shiftwidth=2 softtabstop=2

set backspace=indent,eol,start
set modeline modelines=5

set ignorecase smartcase hlsearch

set swapfile directory=~/.vim/swap
if !isdirectory(&directory)
  call mkdir(&directory, 'p')
endif

set backup writebackup backupcopy=yes backupext=.bak backupdir=~/.vim/backup
if !isdirectory(&backupdir)
  call mkdir(&backupdir, 'p')
endif

if has('persistent_undo')
  set undofile undodir=~/.vim/undo
endif

" m = Also break at a multi-byte character above 255
" M = When joining lines, don't insert a space before or after a multi-byte character
set formatoptions& formatoptions+=mM

set wildmode=list:longest,full
set wildignore=*.o,a.out

" https://groups.google.com/forum/#!topic/vim_dev/SML3mtGd50s
if exists('+breakindent')
  set breakindent
endif

nnoremap : ;
vnoremap : ;
nnoremap ; :
vnoremap ; :

" reload vimrc
nnoremap ,s :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif<CR>

" tab manipulations
nnoremap <silent> <C-n> :<C-u>tabnext<CR>
nnoremap <silent> <C-p> :<C-u>tabprevious<CR>
nnoremap <silent> <C-k> :<C-u>tabclose<CR>

" search next/prev pattern and make it center
nnoremap n nzzzv
nnoremap N Nzzzv

" spellcheck
set spelllang=en_us
nnoremap <silent> <F1> :setlocal spell!<CR>

" Emacs-like keybinds
cnoremap <C-p> <Up>
cnoremap <Up> <C-p>
cnoremap <C-n> <Down>
cnoremap <Down> <C-n>
cnoremap <C-f> <Right>
inoremap <C-f> <Right>
cnoremap <C-b> <Left>
inoremap <C-b> <Left>
cnoremap <C-a> <Home>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-k> <C-o>C
cnoremap <C-k> <C-\>estrpart(getcmdline(), 0, getcmdpos()-1)<CR>

" Swap *gf and *gF
nnoremap gf gF
nnoremap gF gf
nnoremap <C-w>f <C-w>F
nnoremap <C-w>F <C-w>f
nnoremap <C-w>gf <C-w>gF
nnoremap <C-w>gF <C-w>gf

let g:mapleader = '\'
let g:maplocalleader = ','

let $CFLAGS = '-std=c99 -Wall -Wextra -Wshadow -g'
let $CXXFLAGS = '-Wall -Wextra -Wshadow -g -std=c++11'

" colorscheme
if !exists('&t_RB')
  set background=dark
endif
colorscheme ron

runtime macros/matchit.vim

" changelog.vim
let g:changelog_username = 'eagletmt <eagletmt@gmail.com>'

runtime rc/altercmd.vim
runtime rc/coc.vim
runtime rc/colorscheme.vim
runtime rc/global.vim
runtime rc/rust.vim
runtime rc/skk.vim
runtime rc/surround.vim
runtime rc/unite.vim

" others
runtime util/binary.vim
runtime util/capture.vim
runtime util/helpjump.vim
runtime util/quickfix.vim
runtime util/restore-history.vim
runtime util/reverse.vim
runtime util/smart-star.vim
runtime util/sudo.vim
runtime util/whitespace.vim

if filereadable(expand('~/vimrc.local'))
  source ~/vimrc.local
endif
