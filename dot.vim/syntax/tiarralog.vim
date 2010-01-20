syntax clear
syntax case match

syntax match Constant /^\d\d:\d\d:\d\d/
syntax match Identifier /:\zs\w\+\ze>/
syntax match Title / \zs>.\+$/
syntax match UnderLined 'http://[^] []\+'
syntax match UnderLined 'https://[^] []\+'
syntax match Ignore /\d\d/

" syntax match Label /> .\{-}\zs@[A-Za-z0-9_]\+/

