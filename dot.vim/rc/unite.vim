let g:unite_update_time = 100
let g:unite_source_file_ignore_pattern = '\.\(class\|o\|hi\)$'
let g:unite_source_buffer_time_format = ''
let g:unite_source_file_mru_time_format = ''
let g:unite_source_file_mru_filename_format = ''
let g:unite_source_file_mru_limit = 200

call unite#custom#substitute('myfiles', '^\~', $HOME, -100)
nnoremap <silent> mm :<C-u>Unite -buffer-name=myfiles file_mru buffer file file/new<CR>
nnoremap <silent> mf :<C-u>UniteWithBufferDir -buffer-name=myfiles file buffer file/new<CR>
nnoremap <silent> me :<C-u>UniteWithCurrentDir -buffer-name=myfiles file file/new<CR>
nnoremap <silent> ms :<C-u>Unite -buffer-name=myfiles bookmark file file/new<CR>
nnoremap <silent> ma :<C-u>Unite buffer<CR>
nnoremap <silent> mr :<C-u>UniteResume<CR>
nnoremap m<Space> :<C-u>Unite<Space>

let s:ignore_exts = [
      \ 'aux',
      \ 'bbl',
      \ 'blg',
      \ 'dvi',
      \ 'fdb_latexmk',
      \ 'fls',
      \ 'nav',
      \ 'out',
      \ 'snm',
      \ 'toc',
      \ 'vrb',
      \ ]
let s:ignore_pattern = '\.\(' . join(s:ignore_exts, '\|') . '\)$'
call unite#custom#source('file', 'ignore_pattern', s:ignore_pattern)
unlet s:ignore_exts
unlet s:ignore_pattern

augroup vimrc-unite
  autocmd!
  autocmd FileType unite nmap <buffer> <Esc> <Plug>(unite_exit)
  autocmd FileType unite nnoremap <buffer> <silent> t :<C-u>call unite#mappings#do_action('tabopen')<CR>
  autocmd FileType unite nnoremap <buffer> <silent> <C-h> :<C-u>call unite#mappings#do_action('left')<CR>
  autocmd FileType unite nnoremap <buffer> <silent> <C-l> :<C-u>call unite#mappings#do_action('right')<CR>
  autocmd FileType unite nnoremap <buffer> <silent> <C-j> :<C-u>call unite#mappings#do_action('below')<CR>
  autocmd FileType unite nnoremap <buffer> <silent> <C-k> :<C-u>call unite#mappings#do_action('above')<CR>
augroup END

" haddock source
let g:unite_source_haddock_browser = 'firefox'
