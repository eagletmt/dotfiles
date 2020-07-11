call dein#begin('~/.vim/dein', [$MYVIMRC, '~/.vim/rc/dein.vim'])

call dein#add('Shougo/unite.vim', { 'hook_post_source': 'runtime rc/unite.vim' })
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/vimproc', { 'build': 'make' })
call dein#add('kana/vim-altercmd', { 'hook_post_source': 'runtime rc/altercmd.vim' })
call dein#add('kana/vim-smartchr')
call dein#add('thinca/vim-quickrun')
call dein#add('thinca/vim-ref')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-markdown')
call dein#add('tyru/skk.vim')
call dein#add('eagletmt/jsonpp-vim')
call dein#add('neoclide/coc.nvim', { 'branch': 'release' })

call dein#add('rust-lang/rust.vim')
call dein#add('pangloss/vim-javascript')
call dein#add('slim-template/vim-slim')
call dein#add('b4b4r07/vim-hcl')
call dein#add('cespare/vim-toml')
call dein#add('google/vim-jsonnet')
call dein#add('leafgarland/typescript-vim')
call dein#add('peitalin/vim-jsx-typescript')

call dein#add('michalbachowski/vim-wombat256mod', { 'hook_post_source': 'runtime rc/colorscheme.vim' })

call dein#end()

augroup vimrc-dein
  autocmd!
  autocmd VimEnter * call dein#call_hook('post_source')
augroup END
