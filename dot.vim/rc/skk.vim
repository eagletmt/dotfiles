let g:skk_jisyo = '~/vim-skk-jisyo.utf8'
if has('mac')
  let g:skk_large_jisyo = '~/Library/Application Support/AquaSKK/SKK-JISYO.L'
elseif has('unix')
  let g:skk_large_jisyo = '/usr/share/skk/SKK-JISYO.L'
endif

let g:skk_auto_save_jisyo = 1 " don't ask if save
let g:skk_keep_state = 0
let g:skk_kutouten_type = 'jp'
let g:skk_egg_like_newline = 0
let g:skk_show_annotation = 1
let g:skk_use_face = 1
