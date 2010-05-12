setlocal formatoptions-=ro

" errormaker.vim
setlocal makeprg=ruby1.9\ -wc\ %
autocmd BufWritePost <buffer> silent make

