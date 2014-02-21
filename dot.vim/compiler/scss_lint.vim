if exists('b:current_compiler')
  finish
endif
let b:current_compiler = 'scss_lint'

setlocal makeprg=scss-lint
let &l:errorformat = '%f:%l [%t] %m'
