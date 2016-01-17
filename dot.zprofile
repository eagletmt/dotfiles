export GOPATH=$HOME/go

path=($HOME/bin(N) $HOME/.rbenv/bin(N) $HOME/.cabal/bin(N) $HOME/.local/bin(N) $GOPATH/bin(N) /usr/local/bin(N) /usr/texbin(N) $path)
typeset -U path
export PATH

[ -r ~/.nvm/nvm.sh ] && source ~/.nvm/nvm.sh

export TIME_STYLE='+%F %R'

export GTK_IM_MODULE=uim
export QT_IM_MODULE=uim
