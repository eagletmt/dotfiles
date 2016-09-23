if &t_Co == 256 || has('gui_running')
  colorscheme wombat256mod
  " For transparent background
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
  highlight StorageClass term=none ctermfg=143 ctermbg=none
endif
