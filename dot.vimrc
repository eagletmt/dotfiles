set nocompatible

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

runtime rc/neobundle.vim

syntax enable
filetype plugin indent on

set ruler showcmd title number
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
set wildignore=*.o,a.out,*.hi

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

" enable C-n/C-p only for popup menu
inoremap <expr> <C-n> pumvisible() ? "\<C-n>" : ''
inoremap <expr> <C-p> pumvisible() ? "\<C-p>" : ''

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
let $CXXFLAGS = '-Wall -Wextra -Wshadow -g'

" colorscheme
set background=dark
if &t_Co == 256 || has('gui_running')
  colorscheme wombat256mod
  " For transparent background
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
  highlight StorageClass term=none ctermfg=143 ctermbg=none
else
  colorscheme ron
endif

runtime macros/matchit.vim

" changelog.vim
let g:changelog_username = 'eagletmt <eagletmt@gmail.com>'
" necoghc
let g:necoghc_enable_detailed_browse = 1
runtime rc/altercmd.vim
runtime rc/eclim.vim
runtime rc/ghcmod.vim
runtime rc/global.vim
runtime rc/neocomplete.vim
runtime rc/onlinejudge.vim
runtime rc/quickrun.vim
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

command! -nargs=0 Synstack echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
command! -nargs=0 Yank %yank +

nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

if filereadable(expand('~/vimrc.local'))
  source ~/vimrc.local
endif
