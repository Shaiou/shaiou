function xcopy {
    FILE=$1
    echo "Copying contents of $FILE to all clipboards"
    xclip -i -selection clipboard $FILE
}

function xpaste {
    FILE=$1
    echo "Appending the following to $FILE file:"
    xclip -o -selection clipboard | tee -a $FILE
}

function curlco {
    URL=$1
    HOST=$(echo $URL |awk -F'/' '{print $3}')
    FAKE=$2
    curl -vL --connect-timeout 5 --connect-to $HOST:443:$FAKE:443 $URL "${@:3}"
}

function title()
{
   echo -en "\e]2;$1\a"
}
