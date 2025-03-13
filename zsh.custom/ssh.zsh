# Load ssh agent
zstyle :omz:plugins:ssh-agent lazy yes

function sshadd {
    ssh-add /Workspace/Keys/$1
}
