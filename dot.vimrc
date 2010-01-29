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

cnoremap <C-p> <Up>
cnoremap <Up> <C-p>
cnoremap <C-n> <Down>
cnoremap <Down> <C-n>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>

inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^
inoremap <C-k> <C-o>C

let g:mapleader = ' '
nnoremap ,s :source $MYVIMRC<CR>
nnoremap ,d :helptags ~/.vim/doc<CR>
nnoremap ,m :setlocal buftype=nofile<CR>

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
if has('mac')
  let skk_large_jisyo = '~/Library/Application Support/AquaSKK/SKK-JISYO.L'
elseif has('win32')
  let skk_large_jisyo = '~/My Documents/skkdic/SKK-JISYO.L'
endif

let skk_auto_save_jisyo = 1 " don't ask if save
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
let g:fuf_modesDisable = ['mrucmd']
nnoremap [Tab]j :<C-u>FufFileWithCurrentBufferDir!<CR>
nnoremap [Tab]J :<C-u>FufFile! **/<CR>
nnoremap [Tab]i :<C-u>FufBuffer!<CR>
nnoremap [Tab]m :<C-u>FufMruFile!<CR>

" quickfix
autocmd QuickfixCmdPost vimgrep cwindow
nnoremap <C-j> :cn<CR>
nnoremap <C-k> :cp<CR>

" buffer
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>

" cabal build <http://koweycode.blogspot.com/2009/07/vim-and-building-with-cabal.html>
function! s:SetToCabalBuild()
  if glob("*.cabal") != ''
    setlocal makeprg=cabal\ build
  endif
endfunction
autocmd BufEnter *.hs,*.lhs :call s:SetToCabalBuild()

" quickrun.vim
if !exists('g:quickrun_config')
  let g:quickrun_config = {}
  let g:quickrun_config['*'] = {}
  let g:quickrun_config['*'].split = '{"rightbelow"}'
  let g:quickrun_config.lisp = {'command' : 'sbcl --script'}
  let g:quickrun_config.lhaskell = {'tempfile': '{tempname()}.hs', 'eval_template': 'main = print $ %s', 'command': 'runghc'}
endif

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
let g:NeoComplCache_SnippetsDir = $HOME.'/.vim/snippets'
if !exists('g:NeoComplCache_DictionaryFileTypeLists')
  let g:NeoComplCache_DictionaryFileTypeLists = {}
  let g:NeoComplCache_DictionaryFileTypeLists.haskell = $HOME.'/.vim/dict/haskell.dict'
endif

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
let g:twitvim_buffer_form = 1
let g:twitvim_count = 200
if has('mac')
  let g:twitvim_browser = 'open -a Firefox'
endif
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

" http://vim-users.jp/2009/11/hack104/
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>

" surround.vim
let g:surround_no_mappings = 1
nmap          ds   <Plug>Dsurround
nmap          cs   <Plug>Csurround
nmap          ys   <Plug>Ysurround
nmap          yS   <Plug>YSurround
nmap          yss  <Plug>Yssurround
nmap          ySs  <Plug>YSsurround
nmap          ySS  <Plug>YSsurround
if exists(":xmap")
  xmap  s    <Plug>Vsurround
  xmap  S    <Plug>VSurround
else
  vmap  s    <Plug>Vsurround
  vmap  S    <Plug>VSurround
endif

" http://vim-users.jp/2009/12/hack106/
function! s:move_window_into_tab_page(target_tabpagenr)
  " Move the current window into a:target_tabpagenr.
  " If a:target_tabpagenr is 0, move into new tab page.
  if a:target_tabpagenr < 0  " ignore invalid number.
    return
  endif
  let original_tabnr = tabpagenr()
  let target_bufnr = bufnr('')
  let window_view = winsaveview()

  if a:target_tabpagenr == 0
    tabnew
    tabmove  " Move new tabpage at the last.
    execute target_bufnr 'buffer'
    let target_tabpagenr = tabpagenr()
  else
    execute a:target_tabpagenr 'tabnext'
    let target_tabpagenr = a:target_tabpagenr
    topleft new  " FIXME: be customizable?
    execute target_bufnr 'buffer'
  endif
  call winrestview(window_view)

  execute original_tabnr 'tabnext'
  if 1 < winnr('$')
    close
  else
    enew
  endif

  execute target_tabpagenr 'tabnext'
endfunction " }}}

" <space>ao move current buffer into a new tab.
nnoremap <silent> <Space>ao :<C-u>call <SID>move_window_into_tab_page(0)<CR>

autocmd! BufRead,BufNewFile */tiarra/log/* setlocal filetype=tiarralog

" pku
function! s:pku_test(id)
  let id = a:id == '' ? matchstr(expand('%:p:t'), '\zs.\+\ze\.') : a:id

  let url = 'http://acm.pku.edu.cn/JudgeOnline/problem?id=' . id
  let conn = system("curl --silent '" . url . "'")
  let sample_input = substitute(matchstr(conn, 'class="sio">\zs.\{-}\ze</pre>', -1, 1), "\r\n", "\n", 'g')
  let sample_output = substitute(matchstr(conn, 'class="sio">\zs.\{-}\ze</pre>', -1, 2), "\r\n", "\n", 'g')

  if !exists('b:quickrun_config')
    let b:quickrun_config = {}
  endif
  let b:quickrun_config.input = '=' . sample_input

  execute 'new +call\ setline(1,"' . sample_output . '")'
endfunction

command! -nargs=? PKU :call s:pku_test(<q-args>)
nnoremap <Space>p :<C-u>PKU<CR>

