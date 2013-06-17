let g:ghcmod_type_highlight = 'WildMenu'

augroup vimrc-ghcmod
  autocmd!
  autocmd BufWritePost *.hs GhcModCheckAsync
  autocmd BufRead,BufNewFile ~/.xmonad/* let b:ghcmod_ghc_options = ['-i' . expand('~/.xmonad/lib')]
augroup END
