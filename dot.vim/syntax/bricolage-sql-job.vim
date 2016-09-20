if exists('b:current_syntax')
  finish
endif

runtime! syntax/sql.vim
unlet! b:current_syntax

syn include @bricolageYaml syntax/yaml.vim
unlet! b:current_syntax
syn region bricolageSqlJobMetadata start='\v^\s*\/\*\s*$'ms=e-1 end='\v^\s*\*\/\s*$'me=s-1 contains=@bricolageYaml

let b:current_syntax = 'bricolage-sql-job'
