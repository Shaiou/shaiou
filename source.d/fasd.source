alias a='fasd -a'
alias s='fasd -si'
alias sd='fasd -sid'
alias sf='fasd -sif'
alias d='fasd -d'
alias f='fasd -f'
# function to execute built-in cd
fasd_cd() {
  if [ $# -le 1 ]; then
    fasd "$@"
  else
    local _fasd_ret="$(fasd -e 'printf %s' "$@")"
    [ -z "$_fasd_ret" ] && return
    [ -d "$_fasd_ret" ] && cd "$_fasd_ret" || printf %s\n "$_fasd_ret"
  fi
}
alias z='fasd_cd -d'
alias zz='fasd_cd -d -i'

# add zsh hook
_fasd_preexec() {
  { eval "fasd --proc $(fasd --sanitize $1)"; } >> "/dev/null" 2>&1
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec _fasd_preexec

# Flo's alias
function v {
    f -e vim $argv
}

function c {
    f -e cat $argv
}

function zd {
    dir=$(fasd -Rdl "$argv" | fzf -1 -0 --no-sort +m) && cd $dir || return 1
}

function zf {
    file=$(fasd -Rfl "$argv" | fzf -1 -0 --no-sort +m) && vim $file || return 1
}
