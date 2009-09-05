export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export TMPDIR=/var/tmp

# enable pbpaste/pbcopy to input/output utf-8
export __CF_USER_TEXT_ENCODING=${__CF_USER_TEXT_ENCODING/:*:/:0x08000100:}

# set path
path=(${HOME}/bin(N) ${HOME}/.cabal/bin(N) /usr/local/bin(N) /opt/local/bin(N) /usr/local/sbin(N) /usr/X11R6/bin(N) $path)
typeset -U path

# set manpath
manpath=(/opt/local/share/man(N) /usr/local/share/man(N) /usr/local/man(N) $manpath)
typeset -U manpath

# set pkg_config_path
PKG_CONFIG_PATH="/Library/Frameworks/Mono.framework/Versions/2.2/lib/pkgconfig:/opt/local/lib/pkgconfig:/usr/local/lib/pkgconfig:/usr/lib/pkgconfig"

# set editor
EDITOR='/usr/local/bin/vim'

# set pager
PAGER='/opt/local/bin/lv -c'

export PATH MANPATH PKG_CONFIG_PATH EDITOR PAGER

