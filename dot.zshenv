source ~/.zprofile

export EDITOR=vim
export RLWRAP_HOME=$HOME/.rlwrap

# phantomjs
export QT_QPA_FONTDIR=/tmp

if which firefox-developer-edition > /dev/null 2>&1; then
  export BROWSER=firefox-developer-edition
else
  export BROWSER=firefox
fi

fpath=($HOME/.zsh/functions $fpath)

export DISABLE_SPRING=1
