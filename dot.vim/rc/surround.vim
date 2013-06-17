let g:surround_no_mappings = 1
nmap ds <Plug>Dsurround
nmap cs <Plug>Csurround
nmap ys <Plug>Ysurround
nmap yS <Plug>YSurround
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround
nmap ySS <Plug>YSsurround
if exists(":xmap")
  xmap s <Plug>Vsurround
  xmap S <Plug>VSurround
else
  vmap s <Plug>Vsurround
  vmap S <Plug>VSurround
endif
