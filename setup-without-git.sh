#!/bin/sh

function download()
{
  wget http://github.com/$1/$2/tarball/master -O $2.tar.gz
  d=$(basename $(tar ztf $2.tar.gz | head -1))
  tar zxf $2.tar.gz
  if [ $# -lt 3 ]; then
    rmdir $2
    mv $d $2
  else
    rmdir $3
    mv $d $3
  fi
}

download eagletmt dotfiles

pushd dotfiles/dot.vim/bundles
download motemen git-vim git
download motemen hatena-vim hatena
download Shougo neocomplcache
download thinca vim-quickrun quickrun
download thinca vim-ref ref
download Shougo vimfiler
download Shougo vimproc
download Shougo vimpshell
download eagletmt onlinejudge-vim onlinejudge
download kana vim-altercmd altercmd
popd

