" highlight trailing whitespaces
" http://d.hatena.ne.jp/tasukuchan/20070816/1187246177
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
autocmd! WinEnter * match WhitespaceEOL /\s\+$/
