" http://vim-users.jp/2009/11/hack104/
vnoremap * "zy:let @/ = @z<CR>n"
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>
