export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

case $(uname) in
  Darwin)
    export TMPDIR=/var/tmp;
    # enable pbpaste/pbcopy to input/output utf-8
    export __CF_USER_TEXT_ENCODING=${__CF_USER_TEXT_ENCODING/:*:/:0x08000100:};
    path=(${HOME}/src/dmd2/osx/bin(N) ${HOME}/bin(N) ${HOME}/.cabal/bin(N) /usr/local/bin(N) /opt/local/bin(N) /usr/local/sbin(N) /usr/X11R6/bin(N) $path);
    manpath=(/opt/local/share/man(N) /usr/local/share/man(N) /usr/local/man(N) $manpath)
    PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:/opt/local/lib/pkgconfig:/usr/lib/pkgconfig"
    EDITOR='/usr/local/bin/vim';
    PAGER='/usr/local/bin/lv -c';;

  Linux)
    manpath=(/usr/share/man(N) $manpath)
    path=($HOME/bin(N) $HOME/.cabal/bin(N) /usr/local/bin(N) /usr/lib/perl5/site_perl/bin(N) $path)
    EDITOR='vim';
    PAGER='less';;
esac
fpath=($HOME/.zsh/functions $fpath)

typeset -U path
typeset -U fpath
typeset -U manpath

LSCOLORS=gxfxcxdxCxegedxbagacad

export PATH MANPATH PKG_CONFIG_PATH EDITOR PAGER LSCOLORS

