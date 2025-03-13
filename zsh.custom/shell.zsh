# Disable shared history
unsetopt share_history
# Set keylayout
setxkbmap fr

# PATH
export EDITOR="vim"
export GOPATH=/Workspace/Go
export PATH=$PATH:$GOPATH/bin

# Aliases
alias myip="/usr/bin/curl ifconfig.co 2>/dev/null"
alias ll='ls -larth'
alias vi='vim'
alias diff='difft'
alias grep='grep --color=always'
## Key layout
alias fr="setxkbmap fr"
alias us="setxkbmap us"
## Screensave
alias screenunlock="sudo chmod 400 /usr/bin/i3lock"
alias screenlock="sudo chmod 755 /usr/bin/i3lock"

# Load env files
for i in $(find ~/env.d/ -name "*.source")
do
    source $i
done

# Mise autocomplete
eval "$(/home/shailendra/bin/mise activate zsh)"

# Prompt
export ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(argocd aws azure direnv docker docker-compose jira kubectl mise terraform)
# Autocomplete stuff
fpath=(~/zsh.d $fpath)
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle :compinstall filename '/home/shaiou/.zshrc'
autoload -Uz compinit
compinit
