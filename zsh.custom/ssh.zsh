# Load ssh agent
eval $(ssh-agent -s)

function sshadd {
    ssh-add /Workspace/Keys/$1
}
