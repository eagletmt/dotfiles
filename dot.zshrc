# complement
autoload -U compinit predict-on
compinit
predict-on
setopt correct
HISTFILE=~/.zsh-history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups share_history extended_history hist_ignore_space

compctl -g '*.dvi' dvipdfmx
compctl -g '*.tex' platex-utf8
compctl -g '*.cs' mcs gmcs smcs
compctl -g '*.exe' mono
compctl -g '*.lzma' unlzma
compctl -d make
compctl -d locate

# zsh modules
autoload -U zmv
zmodload -i zsh/files

# set special zsh option
setopt auto_pushd	auto_cd no_hup extended_glob no_multios

# User specific aliases and functions
alias ll='ls -AFGlh'
alias la='ls -AFG'
alias du='du -h'
alias df='df -h'
alias tree='/usr/local/bin/tree'
alias vi=vim
alias cgrep='grep --color=always -H -n'
alias vless='/usr/local/share/vim/vim72/macros/less.sh'
alias utf8='nkf --in-place -dw'
alias :q='exit'
# see if configure option has changed
alias helpdiff='diff -u <(gunzip -c help.txt.gz) <(./configure --help)'

GCC_COMMON_OPTIONS='-Wall -Wextra -Wformat=2 -Wcast-qual -Wcast-align \
-Wwrite-strings -Wfloat-equal -Wpointer-arith -Wredundant-decls \
-Wunknown-pragmas -Wstrict-aliasing=2 -Wundef -Wshadow -Wmissing-noreturn \
-Wunreachable-code -Winline \
-Winit-self -Wno-system-headers'
GCC_C_ONLY_OPTIONS='-Wstrict-prototypes -Wbad-function-cast -Wmissing-prototypes'
GCC_CPP_ONLY_OPTIONS='-Woverloaded-virtual -Wno-unreachable-code'
alias gcc="gcc $GCC_COMMON_OPTIONS $GCC_C_ONLY_OPTIONS"
alias g++="g++ $GCC_COMMON_OPTIONS $GCC_CPP_ONLY_OPTIONS"
alias ogcc="gcc $GCC_COMMON_OPTIONS $GCC_C_ONLY_OPTIONS -I/opt/local/include -L/opt/local/lib"
alias og++="g++ $GCC_COMMON_OPTIONS $GCC_CPP_ONLY_OPTIONS -I/opt/local/include -L/opt/local/lib"

# prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '%s-%b'
zstyle ':vcs_info:*' actionformats '%s-%b[%a]'
PROMPT='%n@%m%# '
RPROMPT='%(1v|%K{yellow}%F{black}%1v%f%k|)[%~]'

# key bind
bindkey -e
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

function cd()
{
  builtin cd $* && ll
}

function psgrep()
{
  ps aux | cgrep $(echo $1 | sed 's/^\(.\)/[\1]/')
}

function precmd() {
  psvar=()
  vcs_info
  [ -n "$vcs_info_msg_0_" ] && psvar[1]="$vcs_info_msg_0_"
}

