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
set expandtab tabstop=2 shiftwidth=2 softtabstop=2 smarttab autoindent

" edit
set backspace=indent,eol,start
set modeline modelines=5

" swap
set swapfile directory=~/.vim/swap

" backup
set backup writebackup backupcopy=yes backupdir=~/.vim/backup backupext=.bak

" edit binary
augroup Binary
  autocmd!
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  
  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END

" * works well for Japanese
vnoremap * "zy:let @/ = @z<CR>n"

nnoremap : ;
nnoremap ; :

inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^
inoremap <C-d> <Del>

let g:mapleader = ' '

" filetype
let filetype_m = 'objc'
autocmd FileType c,cpp,perl,python,ruby set cindent

" restore edit history
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

autocmd BufNew,BufRead *.bf set ft=bf

" :TOhtml
let g:use_xhtml = 1
let g:html_use_css = 1
let g:html_no_pre = 1

" command-line mode complement
set wildmode=list:longest,full
set wildignore=*.o,a.out,*.hi

" changelog.vim
let g:changelog_username = 'eagletmt <eagletmt@gmail.com>'

" twitvim.vim
source ~/.twitvim
nnoremap tt :<C-u>CPosttoTwitter

" skk.vim
let skk_jisyo = '~/Library/AquaSKK/skk-jisyo.utf8'
let skk_large_jisyo = '~/Library/AquaSKK/SKK-JISYO.L'
let skk_auto_save_jisyo = 0 " ask if save
let skk_keep_state = 0
let skk_egg_like_newline = 1
let skk_show_annotation = 1
let skk_use_face = 1

" scheme.vim
let g:is_gauche = 1

" fuzzyfinder.vim
" http://vim-users.jp/2009/08/hack-59/
nnoremap [Tab] <Nop>
nmap t [Tab]
nnoremap <silent> [Tab]n :<C-u>tabnew<CR>
nnoremap <silent> [Tab]l :<C-u>tabnext<CR>
nnoremap <silent> [Tab]h :<C-u>tabprevious<CR>
nnoremap <silent> [Tab]k :<C-u>tabclose<CR>
nnoremap [Tab]J :<C-u>tabnew<CR>:FuzzyFinderFile! <C-r>=expand('#:h').'/'<CR><CR>
nnoremap [Tab]j :<C-u>FuzzyFinderFile! <C-r>=expand('%:h').'/'<CR><CR>
nnoremap [Tab]I :<C-u>tabnew<CR>:FuzzyFinderBuffer!<CR>
nnoremap [Tab]i :<C-u>FuzzyFinderBuffer!<CR>

" quickfix
autocmd QuickfixCmdPost vimgrep cwindow

" pbcopy
command! Pbcopy :!pbcopy < %

" cabal build <http://koweycode.blogspot.com/2009/07/vim-and-building-with-cabal.html>
function! s:SetToCabalBuild()
  if glob("*.cabal") != ''
    setlocal makeprg=cabal\ build
  endif
endfunction
autocmd BufEnter *.hs,*.lhs :call s:SetToCabalBuild()

" quickrun.vim
nmap <Leader>r <Plug>(quickrun)<C-w>p

