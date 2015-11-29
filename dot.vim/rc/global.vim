let s:gtags_plugin_path = get(g:, 'gtags_plugin_path', '/usr/share/gtags/gtags.vim')
if filereadable(s:gtags_plugin_path)
  execute 'source' s:gtags_plugin_path
  nnoremap <C-]> :<C-u>GtagsCursor<CR>
  nnoremap <expr> <Space>i ':<C-u>Gtags ' . expand('<cword>')
  nnoremap <expr> <Space>o ':<C-u>Gtags -r ' . expand('<cword>')
endif
