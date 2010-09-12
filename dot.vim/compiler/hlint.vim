if exists("current_compiler")
  finish
endif
let current_compiler = "hlint"
if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=hlint\ %
CompilerSet errorformat=
      \%E%f:%l:%c:\ %trror:\ %m,
      \%W%f:%l:%c:\ %tarning:\ %m,
      \%C\ Found:,
      \%C\ Why\ not:,
      \%C\ \ %m,
      \%Z,

