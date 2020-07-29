call plug#begin('~/.vim/plugged')

Plug 'Shougo/unite.vim', { 'do': ':runtime rc/unite.vim' }
Plug 'Shougo/neomru.vim'
Plug 'kana/vim-altercmd', { 'do': ':runtime rc/altercmd.vim' }
Plug 'kana/vim-smartchr'
Plug 'thinca/vim-ref'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-markdown'
Plug 'tyru/skk.vim'
Plug 'eagletmt/jsonpp-vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'slim-template/vim-slim'
Plug 'b4b4r07/vim-hcl'
Plug 'cespare/vim-toml'
Plug 'google/vim-jsonnet'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

Plug 'michalbachowski/vim-wombat256mod', { 'do': ':runtime rc/colorscheme.vim' }

call plug#end()
