set nocompatible

syntax enable
filetype plugin indent on

" options {{{1
" visual {{{2
set ruler
set showcmd
set hlsearch
set background=dark
set title
set number
set laststatus=2
set statusline=[%L]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.']'}%r%m%=%c:%l/%L
set foldmethod=marker
colorscheme xoria256

" encoding {{{2
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,cp932
set ambiwidth=double
set fileformats=unix,dos

" indent {{{2
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set autoindent

" edit {{{2
set backspace=indent,eol,start
set modeline
set modelines=5

" search {{{2
set ignorecase smartcase

" swap {{{2
set swapfile
if has('win32')
  set directory=~/vimfiles/swap
else
  set directory=~/.vim/swap
endif
if !isdirectory(&directory)
  call mkdir(&directory, 'p')
endif

" backup {{{2
set backup
set writebackup
set backupcopy=yes
if has('win32')
  set backupdir=~/vimfiles/backup
else
  set backupdir=~/.vim/backup
endif
set backupext=.bak
if !isdirectory(&backupdir)
  call mkdir(&backupdir, 'p')
endif

" undo {{{2
set undodir=~/.vim/undo
set undofile

" formatting {{{2
" m = Also break at a multi-byte character above 255
" M = When joining lines, don't insert a space before or after a multi-byte character
set formatoptions& formatoptions+=mM

" command-line mode completion {{{2
set wildmode=list:longest,full
set wildignore=*.o,a.out,*.hi

" autocmd {{{1
" edit binary {{{2
augroup Binary
  autocmd!
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif

  autocmd BufWritePre * if &binary | %!xxd -r | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END

" restore edit history {{{2
augroup RestoreHistory
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" cabal build {{{2
" http://koweycode.blogspot.com/2009/07/vim-and-building-with-cabal.html
function! s:SetToCabalBuild()
  if glob("*.cabal") != ''
    setlocal makeprg=cabal\ build
  endif
endfunction
autocmd BufEnter *.hs,*.lhs :call s:SetToCabalBuild()

" misc {{{2
augroup MyAutoCmd
  autocmd!
  autocmd BufNew * setlocal textwidth=0
augroup END

" general keymaps {{{1
" normal mode {{{2
nnoremap : ;
"nnoremap ; :

nnoremap ,s :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif<CR>
nnoremap <silent> ,d :<C-u>call <SID>helptags_all()<CR>

nnoremap ,m :<C-u>setlocal buftype=nofile bufhidden=hide noswapfile<CR>

nnoremap <silent> <C-q>n :<C-u>tabnew<CR>
nnoremap <silent> <C-n> :<C-u>tabnext<CR>
nnoremap <silent> <C-p> :<C-u>tabprevious<CR>
nnoremap <silent> <C-k> :<C-u>tabclose<CR>

nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap Q :<C-u>quit<CR>

" commandline mode {{{2
cnoremap <C-p> <Up>
cnoremap <Up> <C-p>
cnoremap <C-n> <Down>
cnoremap <Down> <C-n>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-k> <C-\>estrpart(getcmdline(), 0, getcmdpos()-1)<CR>
cnoremap <expr> / getcmdtype() ==# '/' ? '\/' : '/'

" insert mode {{{2
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^
inoremap <C-k> <C-o>C
inoremap <C-w> <C-g>u<C-w>
inoremap <expr> <C-n> pumvisible() ? "\<C-n>" : ''
inoremap <expr> <C-p> pumvisible() ? "\<C-p>" : ''

" visual mode {{{2
vnoremap : ;
"vnoremap ; :
" * works well for Japanese
vnoremap * "zy:let @/ = @z<CR>n"
" http://vim-users.jp/2009/11/hack104/
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>

" settings {{{1
let g:mapleader = '\'

let g:filetype_m = 'objc'

" quickfix {{{1
"nnoremap q Q
"nnoremap q <Nop>
nnoremap qj :cnext<CR>
nnoremap qk :cprev<CR>
nnoremap qq :cc<CR>
nnoremap qo :copen<CR>
nnoremap qc :cclose<CR>
nnoremap qg :grep<Space>
if executable('ack')
  set grepprg=ack\ -a
else
  set grepprg=internal
endif
nnoremap qm :make<CR>
nnoremap qM :make<Space>

" command-line window {{{1
nnoremap ; :
xnoremap ; :
autocmd MyAutoCmd CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin()
  nnoremap <buffer> <Esc> :<C-u>quit<CR>
  startinsert!
endfunction

" :TOhtml {{{2
let g:use_xhtml = 1
let g:html_use_css = 1
let g:html_no_pre = 1

" changelog {{{2
let g:changelog_username = 'eagletmt <eagletmt@gmail.com>'

" matchit {{{2
runtime macros/matchit.vim

" plugins {{{1
function! s:import_bundle(name)
  execute 'set runtimepath+=~/' . (has('win32') ? 'vimfiles' : '.vim') . '/bundles/' . a:name
endfunction

" skk.vim {{{2
let skk_jisyo = '~/vim-skk-jisyo.utf8'
if has('mac')
  let skk_large_jisyo = '~/Library/Application Support/AquaSKK/SKK-JISYO.L'
elseif has('win32')
  let skk_large_jisyo = '~/My Documents/skkdic/SKK-JISYO.L'
elseif has('unix')
  let skk_large_jisyo = '/usr/share/skk/SKK-JISYO.L'
endif

let skk_auto_save_jisyo = 1 " don't ask if save
let skk_keep_state = 0
let skk_kutouten_type = 'en'
let skk_egg_like_newline = 1
let skk_show_annotation = 1
let skk_use_face = 1

" scheme.vim {{{2
let g:is_gauche = 1

" fuf.vim {{{2
call s:import_bundle('fuf')
let g:fuf_modesDisable = ['mrucmd']
let g:fuf_mrufile_exclude = '\vCOMMIT_EDITMSG$'
nnoremap <C-q>j :<C-u>FufFileWithCurrentBufferDir!<CR>
nnoremap <C-q>h :<C-u>FufFile! ~/<CR>
nnoremap <C-q>i :<C-u>FufBuffer!<CR>
nnoremap <C-q>m :<C-u>FufMruFile!<CR>
nnoremap <silent> ,q :<C-u>FufRenewCache<CR>

" quickrun.vim {{{2
call s:import_bundle('quickrun')
nnoremap <silent> <Space>r :QuickRun -mode n<CR>
vnoremap <silent> <Space>r :QuickRun -mode v<CR>
let g:quickrun_config = {
      \ '*': {'split': '{"rightbelow"}'},
      \ 'lisp': {'command' : 'sbcl --script'},
      \ 'lhaskell': {'tempfile': '{tempname()}.hs', 'eval_template': 'main = print $ %s', 'command': 'runghc'},
      \ }

" wwwsearch.vim {{{2
call wwwsearch#add('hoogle', 'http://www.haskell.org/hoogle/?hoogle={keyword}')
nnoremap <Space>sh :<C-u>Wwwsearch -hoogle<Space>
nnoremap <Space>sg :<C-u>Wwwsearch -google<Space>

" vimshell {{{2
call s:import_bundle('vimshell')
let g:vimshell_prompt = $USER . '% '
let g:vimshell_user_prompt = 'getcwd()'
nmap <Leader>sp <Plug>(vimshell_split_switch)
nmap <Leader>sn <Plug>(vimshell_switch)
augroup MyVimShell
  autocmd!
  autocmd FileType vimshell call vimshell#altercmd#define('ll', 'ls -l')
  autocmd FileType vimshell call vimshell#altercmd#define('g', 'git')
  autocmd FileType vimshell nunmap <buffer> q
  autocmd FileType vimshell nunmap <buffer> <C-n>
  autocmd FileType vimshell nunmap <buffer> <C-p>

  autocmd FileType int-* nunmap <buffer> q
  autocmd FileType int-* nunmap <buffer> <C-n>
  autocmd FileType int-* nmap <buffer> K <Plug>(vimshell_int_previous_prompt)
  autocmd FileType int-* nunmap <buffer> <C-p>
  autocmd FileType int-* nmap <buffer> J <Plug>(vimshell_int_next_prompt)
augroup END

" neocomplcache.vim {{{2
call s:import_bundle('neocomplcache')
set complete& complete+=k
set completeopt& completeopt+=menuone
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_max_list = 30
let g:neocomplcache_auto_complete_start_length = 4
let g:neocomplcache_enable_smart_case = 1
if has('win32')
  let g:neocomplcache_snippets_dir = $HOME.'/vimfiles/snippets'
else
  let g:neocomplcache_snippets_dir = $HOME.'/.vim/snippets'
endif
let g:neocomplcache_omni_patterns = {
      \ 'ruby': '',
      \ }
let g:neocomplcache_disable_caching_buffer_name_pattern = '^fuf$'

imap <expr> <C-v> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-v>"
inoremap <expr> <C-h> neocomplcache#smart_close_popup() . "\<C-h>"

" twitvim.vim {{{2
let g:twitvim_buffer_form = 1
let g:twitvim_count = 200
if has('mac')
  let g:twitvim_browser = 'open -a Firefox'
endif
"nnoremap tt :<C-u>CPosttoTwitter
"nnoremap T :<C-u>call MyPosttoTwitter()<CR>
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

" surround.vim {{{2
let g:surround_no_mappings = 1
nmap ds <Plug>Dsurround
nmap cs <Plug>Csurround
nmap ys <Plug>Ysurround
nmap yS <Plug>YSurround
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround
nmap ySS <Plug>YSsurround
if exists(":xmap")
  xmap s <Plug>Vsurround
  xmap S <Plug>VSurround
else
  vmap s <Plug>Vsurround
  vmap S <Plug>VSurround
endif

" gist.vim {{{2
let g:github_user = 'eagletmt'
" let g:github_token = <private>
if executable('pbcopy')
  let g:gist_clip_command = 'pbcopy'
elseif executable('xclip')
  let g:gist_clip_command = 'xclip -i'
endif
let g:gist_open_browser_after_post = 1
if executable('xdg-open')
  let g:gist_browser_command = 'xdg-open %URL%'
elseif executable('open')
  let g:gist_browser_command = 'open %URL%'
endif

" poj.vim {{{2
call s:import_bundle('poj')
let g:poj_user = 'eagletmt_'
let g:poj_prefer_c = 0
let g:poj_prefer_cpp = 0
let g:poj_default_lang_ext = 'cc'
let g:poj_work_dir = '~/work/poj'

" hatena.vim {{{2
call s:import_bundle('hatena')
let g:hatena_user = 'eagletmt'

" ref.vim {{{2
call s:import_bundle('ref')

" vimfiler  {{{2
call s:import_bundle('vimfiler')
let g:vimfiler_as_default_explorer = 1
augroup MyVimFiler
  autocmd!
  autocmd FileType vimfiler nunmap <buffer> j
  autocmd FileType vimfiler nunmap <buffer> k
  autocmd FileType vimfiler nunmap <buffer> q
augroup END

" git.vim {{{2
call s:import_bundle('git')

" vimproc {{{2
call s:import_bundle('vimproc')

" onlinejdge.vim {{{2
call s:import_bundle('onlinejudge')
let g:onlinejudge_account = {
      \ 'poj': {'user': 'eagletmt_'},
      \ 'spoj': {'user': 'eagletmt'},
      \ }

" altercmd {{{2
call s:import_bundle('altercmd')
call altercmd#define('ccd', 'cd %:h')
call altercmd#define('vsend', 'VimShellSendString')
call altercmd#define('ghci', 'VimShellInteractive ghci')
call altercmd#define('irb', 'VimShellInteractive irb')
call altercmd#define('irb19', 'VimShellInteractive irb1.9')


" IndentAnything {{{2
call s:import_bundle('IndentAnything')

" unite {{{2
call s:import_bundle('unite')
let g:unite_update_time = 200
let g:unite_source_file_mru_time_format = ''
nnoremap <Space>fj :<C-u>UniteWithBufferDir buffer file<CR>
nnoremap <Space>fm :<C-u>Unite file_mru buffer file<CR>
nnoremap <Space>fh :<C-u>Unite bookmark file<CR>
autocmd MyAutoCmd FileType unite nunmap <buffer> q
autocmd MyAutoCmd FileType unite nunmap <buffer> l
autocmd MyAutoCmd FileType unite nnoremap <buffer> <silent> t :<C-u>call unite#mappings#do_action('tabopen')<CR>
autocmd MyAutoCmd FileType unite nnoremap <buffer> <silent> <C-h> :<C-u>call unite#mappings#do_action('left')<CR>
autocmd MyAutoCmd FileType unite nnoremap <buffer> <silent> <C-l> :<C-u>call unite#mappings#do_action('right')<CR>
autocmd MyAutoCmd FileType unite nnoremap <buffer> <silent> <C-j> :<C-u>call unite#mappings#do_action('below')<CR>
autocmd MyAutoCmd FileType unite nnoremap <buffer> <silent> <C-k> :<C-u>call unite#mappings#do_action('above')<CR>

" eskk {{{2
"call s:import_bundle('eskk')
"let g:eskk_large_dictionary = {
"      \	'path': "/usr/share/skk/SKK-JISYO.L",
"      \	'sorted': 1,
"      \	'encoding': 'euc-jp',
"      \ }
"call eskk#load()
"let g:eskk_egg_like_newline = 0
"let s:t = eskk#table#create('my_rom_to_hira', 'rom_to_hira')
"call s:t.add('.', '．')
"call s:t.add(',', '，')
"call s:t.add('!', '!')
"call s:t.add(':', ':')
"call s:t.add(';', ';')
"call s:t.add('?', '?')
"call s:t.register()
"unlet s:t
"let g:eskk_mode_use_tables.hira = 'my_rom_to_hira'

" misc {{{1
" reverse lines {{{2
function! s:reverseLines(line1, line2)
  let rev = reverse(getline(a:line1, a:line2))
  for i in range(a:line1, a:line2)
    call setline(i, rev[i-a:line1])
  endfor
endfunction

command! -range Reverse call <SID>reverseLines(<line1>, <line2>)

" highlight trailing whitespaces {{{2
" http://d.hatena.ne.jp/tasukuchan/20070816/1187246177
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
autocmd! WinEnter * match WhitespaceEOL /\s\+$/

" return pseudo-random number in given range {{{2
function! Random(lower, upper)
  let match_end = matchend(reltimestr(reltime()), '\d\+\.') + 1
  return a:lower + reltimestr(reltime())[match_end : ] % (a:upper-a:lower)
endfunction

" move current window into tab page {{{2
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
endfunction

nnoremap <silent> <Space>ao :<C-u>call <SID>move_window_into_tab_page(0)<CR>

" encode.vim {{{2
nmap <Leader>eu <Plug>encodeURIComponent
vmap <Leader>eu <Plug>encodeURIComponent
nmap <Leader>du <Plug>decodeURIComponent
vmap <Leader>du <Plug>decodeURIComponent
nmap <Leader>ej <Plug>encodeJSString
vmap <Leader>ej <Plug>encodeJSString
nmap <Leader>dj <Plug>decodeJSString
vmap <Leader>dj <Plug>decodeJSString

function! s:helptags_all()  " {{{2
  for path in split(&runtimepath, ',')
    if isdirectory(path . '/doc') && filewritable(path . '/doc/tags')
      execute 'helptags ' . path . '/doc'
    endif
  endfor
endfunction

" Capture {{{2
command! -nargs=1 -complete=command Capture call s:cmd_capture(<q-args>)

function! s:cmd_capture(cmd)
  redir => result
  silent execute a:cmd
  redir END

  let bufname = 'Capture: ' . a:cmd
  new
  setlocal buftype=nofile bufhidden=hide noswapfile
  silent file `=bufname`
  call setline(1, split(result))
endfunction

" swap window {{{2
nnoremap <silent> <Plug>swap_window_next :<C-u>call <SID>swap_window(v:count1)<CR>
nnoremap <silent> <Plug>swap_window_prev :<C-u>call <SID>swap_window(-v:count1)<CR>
nnoremap <silent> <Plug>swap_window_j :<C-u>call <SID>swap_window_dir(v:count1, 'j')<CR>
nnoremap <silent> <Plug>swap_window_k :<C-u>call <SID>swap_window_dir(v:count1, 'k')<CR>
nnoremap <silent> <Plug>swap_window_h :<C-u>call <SID>swap_window_dir(v:count1, 'h')<CR>
nnoremap <silent> <Plug>swap_window_l :<C-u>call <SID>swap_window_dir(v:count1, 'l')<CR>
nnoremap <silent> <Plug>swap_window_t :<C-u>call <SID>swap_window_dir(v:count1, 't')<CR>
nnoremap <silent> <Plug>swap_window_b :<C-u>call <SID>swap_window_dir(v:count1, 'b')<CR>

function! s:modulo(n, m)
  let d = a:n * a:m < 0 ? 1 : 0
  return a:n + (-(a:n + (0 < a:m ? d : -d)) / a:m + d) * a:m
endfunction

function! s:swap_window(n)
  let curbuf = bufnr('%')
  let target = s:modulo(winnr() + a:n - 1, winnr('$')) + 1
  execute 'hide' winbufnr(target) 'buffer'
  execute target 'wincmd w'
  execute curbuf 'buffer'
endfunction

function! s:swap_window_dir(n, dir)
  let curbuf = bufnr('%')
  execute a:n 'wincmd' a:dir
  let target = winnr()
  let targetbuf = bufnr('%')
  if curbuf != targetbuf
    wincmd p
    execute 'hide' targetbuf 'buffer'
    execute target 'wincmd w'
    execute curbuf 'buffer'
  endif
endfunction

nmap <Space>wj <Plug>swap_window_j
nmap <Space>wk <Plug>swap_window_k
nmap <Space>wh <Plug>swap_window_h
nmap <Space>wl <Plug>swap_window_l
nmap <Space>wt <Plug>swap_window_t
nmap <Space>wb <Plug>swap_window_b

" select c-style if {{{2
nnoremap <silent> <Plug>select_cstyle_if :<C-u>call <SID>select_cstyle_if()<CR>
function! s:select_cstyle_if()  " {{{
  let orig_view = winsaveview()
  let if_start_pos = []
  while searchpair('{', '', '}', 'bW', 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string\\|character"') != 0
    let brace_start_pos = getpos('.')
    normal! ge
    let save = @"
    normal! yl
    let t = @"
    let @" = save
    if t == ')'
      call searchpair('(', '', ')', 'bW', 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string\\|character"')
      normal! b
      let s = expand('<cword>')
      if s == 'if' || s == 'elsif'
        let if_start_pos = getpos('.')
        break
      endif
    elseif expand('<cword>') == 'else'
      normal! b
      let if_start_pos = getpos('.')
      break
    endif
  endwhile
  if if_start_pos == []
    echohl ErrorMsg
    echo "'if' not found"
    echohl None
    call winrestview(orig_view)
    return
  endif

  normal! m[
  call setpos('.', brace_start_pos)
  call searchpair('{', '', '}', 'W', 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string\\|character"')
  normal! m]
  normal! `[v`]
endfunction " }}}
" example
nmap <Space>if <Plug>select_cstyle_if

" find next help tagjump {{{2
" original: http://d.hatena.ne.jp/mFumi/20100612/1276355084
autocmd MyAutoCmd FileType help nnoremap <buffer> <silent> <Tab> :<C-u>call <SID>find_next_help_tagjump('W')<CR>
autocmd MyAutoCmd FileType help nnoremap <buffer> <silent> <S-Tab> :<C-u>call <SID>find_next_help_tagjump('bW')<CR>
function! s:find_next_help_tagjump(flag)  " {{{
  let orig_view = winsaveview()
  let helpHyperTextJump	= '\\\@<!|[^"*|]\+|'
  let helpOption1 = "'[a-z]\\{2,\\}'"
  let helpOption2 = "'t_..'"
  let regex = join([helpHyperTextJump, helpOption1, helpOption2], '\|')
  while search(regex, a:flag) > 0
    if synIDattr(synID(line('.'), col('.'), 0), 'name') =~# '^\(helpBar\|helpOption\)$'
      return
    endif
  endwhile
  call winrestview(orig_view)
endfunction " }}}

" sudo write {{{2
command! -nargs=? -range=% SudoWrite call <SID>sudo_write(<q-args>, <line1>, <line2>)

function! s:sudo_write(path, line1, line2)
  if empty(a:path)
    let path = expand('%')
  else
    let path = a:path
  endif
  silent execute 'write !sudo tee >/dev/null ' . path
  setlocal nomodified
endfunction

" private {{{1
if filereadable(expand('~/vimrc.local'))
  source ~/vimrc.local
endif

" vim: set fdm=marker:

