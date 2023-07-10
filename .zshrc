HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Load ssh agent
eval $(ssh-agent -s)

#Prompt
#$'\U2388'
KUBE_PS1=$'\u2638\ufe0f'
setopt promptsubst
autoload -U colors && colors
function pset {
    export PS1='%B%{$fg[blue]%}${KUBE_PS1} $(echo ${KUBECONFIG##*/})%{$fg[white]%}[${AWS_PROFILE##*-}/${AWS_REGION}]%{$fg[yellow]%}%n%{$fg[cyan]%}%d%{$fg[red]%}($(git branch 2>/dev/null|awk -F" " "/*/ {print $2}"))%{$reset_color%}
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

notify_workspace () {
    RETURN_CODE=$?
    CURRENT_WORKSPACE=$(wmctrl -d |awk '/*/ {print $NF}')
    if [ ! $WORKSPACE = $CURRENT_WORKSPACE ]
    then
        EXECUTABLE=$(echo $COMMAND | awk '{print $1}')
        if [ -f ~/Icons/${EXECUTABLE}.png ];then
            notify-send -i ~/Icons/${EXECUTABLE}.png "Workspace: $WORKSPACE" "command:=$EXECUTABLE $COMMAND\nreturn code: $RETURN_CODE"
        else
            notify-send "Workspace: $WORKSPACE" "command:=$COMMAND\nreturn code: $RETURN_CODE"
        fi
    fi
    WORKSPACE=$(wmctrl -d |awk '/*/ {print $NF}')
}
add-zsh-hook preexec get_cmd
add-zsh-hook precmd notify_workspace

for i in $(find ~/env.d/ -name "*.source")
do
    source $i
done
for i in $(find ~/source.d/ -name "*.source")
do
    source $i
done

#key layout
setxkbmap fr
alias fr="setxkbmap fr"
alias us="setxkbmap us"
#Aliases and exports
export GOPATH=/Workspace/Go
export PATH=~/bin:~/.screenlayout:$GOPATH/bin:$PATH:/opt/conduktor-2.18.1/bin/
export EDITOR="vim"
alias myip="/usr/bin/curl ifconfig.co 2>/dev/null"
alias ll='ls -larth'
alias vi='vim'
alias diff='diff -u --color'
alias grep='grep --color=always'

eval "$(direnv hook zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
