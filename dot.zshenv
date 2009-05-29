export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export TMPDIR=/var/tmp

# enable pbpaste/pbcopy to input/output utf-8
export __CF_USER_TEXT_ENCODING=${__CF_USER_TEXT_ENCODING/:*:/:0x08000100:}

# set path
if ! echo $PATH | grep -q '/usr/X11R6/bin'; then
  PATH="/usr/X11R6/bin:$PATH"
fi
if ! echo $PATH | grep -q '/usr/local/sbin'; then
	PATH="/usr/local/sbin:${PATH}"
fi
if ! echo $PATH | grep -q '/opt/local/bin'; then
  PATH="/opt/local/bin:${PATH}"
fi
if ! echo $PATH | grep -q '/usr/local/bin'; then
  PATH="/usr/local/bin:$PATH"
fi
if ! echo $PATH | grep -q "${HOME}/bin"; then
	PATH="${HOME}/bin:${PATH}"
fi
if ! echo $PATH | grep -q '/usr/local/cross/bin'; then
  PATH="$PATH:/usr/local/cross/bin"
fi
if ! echo $PATH | grep -q '/usr/local/scala/bin'; then
  PATH="$PATH:/usr/local/scala/bin"
fi

# set manpath
if ! echo $MANPATH | grep -q '/usr/local/share/man'; then
	MANPATH="/usr/local/share/man:$MANPATH"
fi

if ! echo $MANPATH | grep -q '/opt/local/share/man'; then
  MANPATH="/opt/local/share/man:${MANPATH}"
fi

# set pkg_config_path
PKG_CONFIG_PATH="/Library/Frameworks/Mono.framework/Versions/2.2/lib/pkgconfig:/opt/local/lib/pkgconfig:/usr/local/lib/pkgconfig:/usr/lib/pkgconfig"

# set editor
EDITOR='/usr/local/bin/vim'

# set pager
PAGER='/opt/local/bin/lv'

export PATH MANPATH PKG_CONFIG_PATH EDITOR PAGER

