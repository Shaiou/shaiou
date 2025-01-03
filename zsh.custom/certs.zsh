CONFGITEMPLATE='{"signing":{"default":{"expiry":"43800h"},"profiles":{"default":{"usages":["signing","keyencipherment","serverauth","clientauth"],"expiry":"8760h"},"intermediate":{"usages":["signing","keyencipherment","certsign","crlsign"],"expiry":"8760h","ca_constraint":{"is_ca":true,"max_path_len":1}}}}}'
CSRTEMPLATE='{"CN":"__CN__","hosts":[""],"key":{"algo":"ecdsa","size":256},"names":[{"C":"FR","ST":"FR","L":"Paris"}]}'
function gencert {
    CAPATH=${CAPATH:-"."}
    TYPE=$1
    CN=$2
    HOSTS=$3
    HOSTOPT=""
    case $TYPE in
        ca)
            echo $CONFGITEMPLATE > $CAPATH/cfssl-config.json
            echo $CSRTEMPLATE | sed -e "s#__CN__#${CN:-`hostname`} Awesome CA#" > $CAPATH/ca-csr.json
            set -v
            PWD=$CAPATH cfssl gencert -initca ca-csr.json | cfssljson -bare ca -
            set +v
            ;;
        intermediate)
            echo $CONFGITEMPLATE > $CAPATH/cfssl-config.json
            echo $CSRTEMPLATE | sed -e "s#__CN__#${CN:-`hostname`} Awesome Intermediate CA#" > $CAPATH/intermediate-ca-csr.json
            set -v
            PWD=$CAPATH cfssl gencert -ca=$CAPATH/ca.pem -ca-key=$CAPATH/ca-key.pem -config=$CAPATH/cfssl-config.json -profile=intermediate ${CAPATH}/intermediate-ca-csr.json | cfssljson -bare intermediate
            set +v
            ;;
        client|server)
            if [[ ! -z $HOSTS ]]
            then
                HOSTOPT="-hostname=$HOSTS"
            fi
            echo $CSRTEMPLATE | sed -e "s#__CN__#$CN#" > $CN-csr.json
            set -v
            cfssl gencert -ca=$CAPATH/ca.pem -ca-key=$CAPATH/ca-key.pem -config=$CAPATH/cfssl-config.json -profile=default $HOSTOPT $CN-csr.json | cfssljson -bare $CN
            set +v
            ;;
    esac
}
function checkcert {
    openssl x509 -in $1 -noout -text |egrep -v "^\s+([a-f0-9:]{2,3})+$"
}
function checkcsr {
    openssl req -in $1 -noout -text |egrep -v "^\s+([a-f0-9:]{2,3})+$"
}
