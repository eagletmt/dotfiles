if exists('b:current_syntax')
  finish
endif

runtime! syntax/sql.vim
unlet! b:current_syntax

syn include @bricolageYaml syntax/yaml.vim
unlet! b:current_syntax
syn region bricolageEmbeddedDefinition start='\%^\/\*' end='\v^\*\/' keepend contains=bricolageEmbeddedDefinitionBegin,@bricolageYaml,bricolageEmbeddedDefinitionEnd
syn match bricolageEmbeddedDefinitionBegin '\%^\/\*' contained
syn match bricolageEmbeddedDefinitionEnd '\v^\*\/' contained

hi def link bricolageEmbeddedDefinitionBegin PreProc
hi def link bricolageEmbeddedDefinitionEnd PreProc

let b:current_syntax = 'bricolage-sql-job'
