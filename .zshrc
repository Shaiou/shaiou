HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

#Prompt
setopt promptsubst
autoload -U colors && colors
function pset {
    export PS1='%B%{$fg[white]%}[${AWS_PROFILE}/${AWS_REGION}]%{$fg[yellow]%}%n@%m %{$fg[cyan]%}%d%{$fg[red]%}($(git branch 2>/dev/null|awk  "/*/ {print $2}"))%{$reset_color%}
${(r:$COLUMNS::_:)}'
}
pset

#Zsh stuff
fpath=(~/zsh.d $fpath)
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle :compinstall filename '/home/shaiou/.zshrc'
autoload -Uz compinit
compinit
autoload -Uz add-zsh-hook
get_cmd () {
    COMMAND=$1
}

get_workspace () {
    RETURN_CODE=$?
    CURRENT_WORKSPACE=$(wmctrl -d |awk '/*/ {print $NF}')
    if [ ! $WORKSPACE = $CURRENT_WORKSPACE ]
    then
        notify-send $WORKSPACE "command: $COMMAND\nreturn code: $RETURN_CODE"
    fi
    WORKSPACE=$(wmctrl -d |awk '/*/ {print $NF}')
}
add-zsh-hook preexec get_cmd
add-zsh-hook precmd get_workspace

for i in $(find ~/env.d/ -name "*.source")
do
    source $i
done
for i in $(find ~/source.d/ -name "*.source")
do
    source $i
done

#Aliases and exports
export GOPATH=/Workspace/Go
export PATH=$PATH:~/bin:$GOPATH/bin
export EDITOR="vim"
alias myip="/usr/bin/curl ifconfig.co 2>/dev/null"
alias ll='ls -lart'
alias vi='vim'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

