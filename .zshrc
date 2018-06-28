# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle :compinstall filename '/home/shaiou/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
#

setopt promptsubst
autoload -U colors && colors
local gitprompt="$(git branch 2>/dev/null|awk  '/*/ {print $2}')"
function pset {
    export PS1='%B%{$fg[white]%}[${AWS_PROFILE}/${AWS_REGION}/${WORK}/${KUBENV}]%{$fg[yellow]%}%n@%m %{$fg[cyan]%}%d%{$fg[red]%}(${gitprompt})%{$reset_color%}
${(r:$COLUMNS::_:)}'
}
pset

alias myip="/usr/bin/curl ifconfig.co 2>/dev/null"
for i in $(find ~/env.d/ -name "*.source")
do
    source $i
done
export EDITOR="vi"
for i in $(find ~/source.d/ -name "*.source")
do
    source $i
done

