HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

#Prompt
setopt promptsubst
autoload -U colors && colors
function pset {
    export PS1='%B%{$fg[white]%}[${AWS_PROFILE}/${AWS_REGION}/${WORK}/${KUBENV}]%{$fg[yellow]%}%n@%m %{$fg[cyan]%}%d%{$fg[red]%}($(git branch 2>/dev/null|awk  "/*/ {print $2}"))%{$reset_color%}
${(r:$COLUMNS::_:)}'
}
pset

#Zsh stuff
fpath=(~/zsh.d $fpath)
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle :compinstall filename '/home/shaiou/.zshrc'
autoload -Uz compinit
compinit

for i in $(find ~/env.d/ -name "*.source")
do
    source $i
done
for i in $(find ~/source.d/ -name "*.source")
do
    source $i
done

#Aliases and exports
export EDITOR="vi"
alias myip="/usr/bin/curl ifconfig.co 2>/dev/null"
alias ll='ls -lart'
