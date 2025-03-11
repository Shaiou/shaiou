function vaultrenew {
    for server in $(vault-token-helper list 2>&1 |awk '/https/ {print $1}')
    do
        echo "Renewing vault token for $server"
        export VAULT_ADDR=$server; vault token renew $(vault token lookup --format json |jq -r '.data.id')
    done
}

