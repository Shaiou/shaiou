# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
HISTFILESIZE=2000
HISTSIZE=1000

shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias grep='grep --color=auto'
    alias ll='ls -alrt --color=auto'
    alias ls='ls --color=auto'
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

CYAN="\[\033[1;36m\]"
RESET="\[\033[0m\]"
RED="\[\033[1;31m\]"
YELLOW="\[\033[1;33m\]"

function pset {
    export PS1="$YELLOW\u@\h:..."$CYAN'${PWD#"${PWD%/*/*}/"}'"$RED\$(__git_ps1 '(%s)')$RESET#"
}

alias myip="/usr/bin/curl ifconfig.co 2>/dev/null"
for i in $(find ~/env.d/ -name "*.source")
do
    source $i
done
export EDITOR="vi"
pset
for i in $(find ~/source.d/ -name "*.source")
do
    source $i
done

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
