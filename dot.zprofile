export GOPATH=$HOME/go

path=($HOME/bin(N) $HOME/.rbenv/bin(N) $HOME/.cabal/bin(N) $GOPATH/bin(N) /usr/local/bin(N) $path)
typeset -U path
export PATH

[ -r ~/.nvm/nvm.sh ] && source ~/.nvm/nvm.sh

export TIME_STYLE='+%F %R'

export NOKOGIRI_USE_SYSTEM_LIBRARIES=1
