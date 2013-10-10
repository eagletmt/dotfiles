alias vi=vim
alias view='vim -R'
alias ll='ls -AlFh --color=auto'
alias g=git
alias c=cabal
alias b=bundle
alias m=mplayer

autoload -U colors
colors
PROMPT='%n@%m%# '
RPROMPT='%(1v|%K{yellow}%F{black}%1v%f%k|)[%~]'

HISTFILE=$HOME/.zsh-history
SAVEHIST=100000
HISTSIZE=100000
setopt hist_ignore_dups share_history extended_history hist_ignore_space hist_reduce_blanks append_history

autoload -U compinit predict-on
compinit
predict-on
setopt correct

stty sane
stty -ixon -ixoff
bindkey -e
zle -N predict-on
bindkey "^O" predict-on
bindkey "^W" vi-backward-kill-word
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

autoload -U add-zsh-hook
if [ x"$WINDOW" != x'' ]; then
  function screen_preexec() {
    echo -ne "\ek$(echo $1 | cut -d ' ' -f1)\e\\"
  }
  add-zsh-hook preexec screen_preexec
  function screen_precmd() {
    echo -ne "\ek$SHELL\e\\"
  }
fi

autoload -U vcs_info
zstyle ':vcs_info:*' formats '%s-%b'
zstyle ':vcs_info:*' actionformats '%s-%b[%a]'
function vcsinfo_precmd() {
  psvar=()
  vcs_info
  [ -n "$vcs_info_msg_0_" ] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd vcsinfo_precmd

if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi

arch_rc="$HOME/.zshrc.$(uname)"
[ -r "$arch_rc" ] && source "$arch_rc"

local_rc="$HOME/.zshrc.local"
[ -r "$local_rc" ] && source "$local_rc"
