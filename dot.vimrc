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
if !isdirectory(&directory)
  call mkdir(&directory, 'p')
endif

" backup
set backup writebackup backupcopy=yes backupdir=~/.vim/backup backupext=.bak
if !isdirectory(&backupdir)
  call mkdir(&backupdir, 'p')
endif

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
vnoremap : ;
vnoremap ; :

inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^
inoremap <C-k> <C-o>C

let g:mapleader = ' '
nnoremap ,s :source $MYVIMRC<CR>

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

" skk.vim
let skk_jisyo = '~/vim-skk-jisyo.utf8'
let skk_large_jisyo = '~/Library/Application Support/AquaSKK/SKK-JISYO.L'
let skk_auto_save_jisyo = 0 " ask if save
let skk_keep_state = 0
let skk_kutouten_type = 'en'
let skk_egg_like_newline = 1
let skk_show_annotation = 1
let skk_use_face = 1

" scheme.vim
let g:is_gauche = 1

" http://vim-users.jp/2009/08/hack-59/
nnoremap [Tab] <Nop>
nmap t [Tab]
nnoremap <silent> [Tab]n :<C-u>tabnew<CR>
nnoremap <silent> [Tab]l :<C-u>tabnext<CR>
nnoremap <silent> [Tab]h :<C-u>tabprevious<CR>
nnoremap <silent> [Tab]k :<C-u>tabclose<CR>

" fuf.vim
nnoremap [Tab]j :<C-u>FufFile! <C-r>=expand('%:h').'/'<CR><CR>
nnoremap [Tab]i :<C-u>FufBuffer!<CR>

" quickfix
autocmd QuickfixCmdPost vimgrep cwindow

" pbcopy
nnoremap <Space>p :<C-u>w !pbcopy<CR>
vnoremap <Space>p :w !pbcopy<CR>

" cabal build <http://koweycode.blogspot.com/2009/07/vim-and-building-with-cabal.html>
function! s:SetToCabalBuild()
  if glob("*.cabal") != ''
    setlocal makeprg=cabal\ build
  endif
endfunction
autocmd BufEnter *.hs,*.lhs :call s:SetToCabalBuild()

" quickrun.vim
nmap <Leader>r <Plug>(quickrun)<C-w>p

" wwwsearch.vim
call wwwsearch#add('hoogle', 'http://www.haskell.org/hoogle/?hoogle={keyword}')
nnoremap <Space>sh :<C-u>Wwwsearch -hoogle<Space>
nnoremap <Space>sg :<C-u>Wwwsearch -google<Space>

" http://vim-users.jp/2009/10/hack81/
"inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

set matchpairs& matchpairs+=<:>

" m = Also break at a multi-byte character above 255
" M = When joining lines, don't insert a space before or after a multi-byte character
set formatoptions& formatoptions+=mM

nnoremap n nzzzv
nnoremap N Nzzzv

" vimshell
let g:VimShell_Prompt = $USER . '% '
let g:VimShell_UserPrompt = 'getcwd()'
nmap <Space>v <Plug>(vimshell_create)
let g:VimShell_EnableAutoLs = 1

" neocomplcache.vim
set complete& complete+=k
set completeopt& completeopt+=menuone
let g:NeoComplCache_EnableAtStartup = 1
let g:NeoComplCache_SmartCase = 1
imap <silent> <C-l> <Plug>(neocomplcache_snippets_expand)

if filereadable(expand('~/.private.vim'))
  source ~/.private.vim
endif

function! s:reverseLines(line1, line2)
  let rev = reverse(getline(a:line1, a:line2))
  for i in range(a:line1, a:line2)
    call setline(i, rev[i-a:line1])
  endfor
endfunction

command! -range Reverse call <SID>reverseLines(<line1>, <line2>)

" http://d.hatena.ne.jp/tasukuchan/20070816/1187246177
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
autocmd! WinEnter * match WhitespaceEOL /\s\+$/

" twitvim.vim
nnoremap tt :<C-u>CPosttoTwitter
nnoremap T :<C-u>call MyPosttoTwitter()<CR>
function! MyPosttoTwitter()
  if g:twitvim_source ==# 'random'
    let g:twitvim_source = s:sources[Random(1, len(s:sources))]
    CPosttoTwitter
    let g:twitvim_source = 'random'
  else
    CPosttoTwitter
  endif
endfunction

command! -nargs=? -complete=custom,CompletionSourceTwitter SourceTwitter call SetSource(<q-args>)
function! SetSource(arg)
  if len(a:arg) == 0
    echo g:twitvim_source
  else
    let g:twitvim_source = a:arg
  endif
endfunction
let s:sources = ['random', 'twitvim', 'Tween', 'twitterfeed', 'TwitPic', 'UberTwitter',
      \ 'twit.el', 'tmitter', 'Seesmic', 'twidroid', 'Tumblr', 'Twit', 'YoruFukurou',
      \ 'TwitterIrcGateway', 'termtter', 'web', 'mobile web', 'TweetDeck', 'Tweetie',
      \ 'Ubiquity', 'Twittexceler', 'Twipper', 'Twitterfic']
function! CompletionSourceTwitter(ArgLead, CmdLine, CursorPos)
  return join(s:sources, "\n")
endfunction
function! Random(lower, upper)
  let match_end = matchend(reltimestr(reltime()), '\d\+\.') + 1
  return a:lower + reltimestr(reltime())[match_end : ] % (a:upper-a:lower)
endfunction

