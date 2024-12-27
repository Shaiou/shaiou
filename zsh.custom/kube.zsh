alias k=kubectl

function kubeset {
    export KUBENV=$1
    export KUBECONFIG=~/.kube/$KUBENV
}

function runpod {
    IMAGE=${1:-arunvelsriram/utils}
    NAMESPACE=${2:-default}
    SERVICE_ACCOUNT=${3:-default}
    PODNAME="shai-manual-run-pod"
    kubectl -n $NAMESPACE delete pod $PODNAME > /dev/null 2>&1
    kubectl -n $NAMESPACE run $PODNAME --image=$IMAGE  -i --tty --restart=Never --rm --overrides='{ "spec": { "serviceAccount": "'$SERVICE_ACCOUNT'" }  }'
}

function rootpod {
    NAMESPACE=${1:-default}
    IMAGE=${2:-debian}
    PODNAME="shai-manual-root-pod"
    kubectl -n $NAMESPACE delete pod $PODNAME > /dev/null 2>&1
    kubectl -n $NAMESPACE run $PODNAME --image=$IMAGE --overrides='
{
  "apiVersion": "v1",
  "spec": {
    "template": {
      "spec": {
        "containers": [
          {
            "name": "$PODNAME",
            "image": "$IMAGE",
            "securityContext": {
                "privileged": true,
                "runAsUser": 0
            },
            "stdin": true,
            "stdinOnce": true,
            "tty": true,
            "volumeMounts": [{
              "mountPath": "/mnt",
              "name": "host-root"
            }]
          }
        ],
        "volumes": [{
          "name":"host-root",
          "hostPath":{
            "path": "/",
            "type": "Directory"
          }
        }]
      }
    }
  }
}
' -i --tty --restart=Never --rm
}

export PATH=$PATH:$HOME/.krew/bin
