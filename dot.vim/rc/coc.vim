let g:coc_open_url_command = 'firefox'

nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-reference)

command! -nargs=0 CocOrganizeImport call CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0 CocHover call CocAction('doHover')

nnoremap go :<C-u>CocOrganizeImport<CR>
nnoremap gh :<C-u>CocHover<CR>
