# Exports
export AWS_DEFAULT_PROFILE=shd
export AWS_DEFAULT_REGION=eu-west-1
export AWS_PROFILE=shd
export AWS_REGION=eu-west-1
export CLOUDSDK_CORE_PROJECT=blv-shared-services
export DOCKER_REGISTRY=907182295670.dkr.ecr.eu-west-1.amazonaws.com
export PATH=$PATH:~/.volta/bin
export VAULT_ADDR=https://vault.shd.gcp.believe.tech
export VAULT_LOGIN_WITH_BROWSER=false

# Aliases
alias sso="aws sso login --profile shd"
alias vaultlogin="vault login --method oidc --path /azure-oidc role=vault-admins"
#alias vaultlogin="vault login --field=policies"
alias azlogin="/Workspace/Git/idp/resource-plane/infra-core/docker/infra-tools/azure-ad-login-from-vault.sh"
alias vpnup="/usr/bin/warp-cli disconnect; warp-cli connect"

# Docker tags
function retag {
    REPO=$1
    OLD=$2
    NEW=$3
    echo "retagging ${REPO}:${OLD} ${REPO}:${NEW}"
    MANIFEST=$(aws ecr batch-get-image --repository-name $REPO --image-ids imageTag=$OLD --output text --query 'images[].imageManifest')
    aws ecr put-image --repository-name $REPO --image-tag $NEW --image-manifest "$MANIFEST"
}

function multiretag {
    REPO=$1
    OLD=$2
    NEW=$3
    for ARCH in amd64 arm64
    do
        retag $REPO ${OLD}-${ARCH} ${NEW}-${ARCH}
    done
    retag $REPO $OLD $NEW
}

# Azure
function azlogout {
    rm -rf ~/.azure
    unset  ARM_CLIENT_ID ARM_CLIENT_SECRET ARM_TENANT_ID ARM_SUBSCRIPTION_ID
}

# SCREENS
function redock {
    profile=$(autorandr --current)
    case $profile in
        "office")
            i3-msg '[workspace=2]' move workspace to output DP-2-2
            i3-msg '[workspace=4]' move workspace to output DP-2-2
            i3-msg 'focus output DP-2-2, workspace 2;'
            i3-msg '[workspace=3]' move workspace to output DP-2-3
            i3-msg 'focus output DP-2-3, workspace 3;'
            ;;
        "home")
            i3-msg '[workspace=2]' move workspace to output DP-2
            i3-msg '[workspace=3]' move workspace 2
            i3-msg '[workspace=4]' move workspace to output DP-2
            ;;
    esac
}

function undock {
    autorandr --load  mobile
}

# CD magic
function platform {
    echo "Found the following folders for this stack"
    find /Workspace/Git/idp/resource-plane/infra-core/terraform/platforms -mindepth 4 -maxdepth 4 -name $1
    echo ""
    read "?Choose your platform:" PLATFORM
    cd $PLATFORM
}

# GCP
function gstate {
    ACTION=$1
    ITEM=$2
    case $ACTION in
        "ls")
            for bucket in blv-tf-europe-west1 blv-tf-europe-west4 blv-tf-global
            do
                gtree gs://$bucket |grep $ITEM
            done
            ;;
        "rm")
            gcloud storage rm --project blv-tfstate $ITEM
            ;;
        "*")
            print "Unknown action, choose ls or rm"
            ;;
    esac
}

