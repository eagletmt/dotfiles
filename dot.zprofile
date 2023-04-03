export GOPATH=$HOME/go

path=($HOME/bin(N) $HOME/.cargo/bin(N) $HOME/.rbenv/bin(N) $HOME/.local/bin(N) /usr/local/bin(N) $path)
typeset -U path
export PATH

export PAGER=less

export TIME_STYLE='+%F %R'

export GTK_IM_MODULE=uim
export QT_IM_MODULE=uim

if [ -z "$SSH_AUTH_SOCK" ]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi
