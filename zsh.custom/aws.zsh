export aws_sdk_load_config=1

function clearaws {
    unset AWS_PROFILE
    unset AWS_DEFAULT_PROFILE
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN
}

function awset {
    export PREV_AWS_PROFILE=$AWS_PROFILE
    export AWS_DEFAULT_PROFILE=$1
    export AWS_PROFILE=$1
    noglob ssh-add /Workspace/Keys/${AWS_PROFILE}*pem 2>/dev/null
}

function aws-id {
    AWS_PAGER="" aws sts get-caller-identity
}

#You need to have a line with mfa_$profile with the serial of your mfa device
function mfa {
    PROFILE=$1
    TOKEN=$2
    awset $PROFILE
    MFA=$(awk '/mfa_'$PROFILE'/ {print $3}' ~/.aws/credentials)
    TEMP=$(aws sts get-session-token --serial-number $MFA --token-code $TOKEN --query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]' --output text)

    AWS_ACCESS_KEY_ID=$(echo $TEMP |awk '{print $1}')
    AWS_SECRET_ACCESS_KEY=$(echo $TEMP |awk '{print $2}')
    AWS_SESSION_TOKEN=$(echo $TEMP |awk '{print $3}')

    aws configure set profile.${PROFILE}-mfa.aws_access_key_id $AWS_ACCESS_KEY_ID
    aws configure set profile.${PROFILE}-mfa.aws_secret_access_key $AWS_SECRET_ACCESS_KEY
    aws configure set profile.${PROFILE}-mfa.aws_session_token $AWS_SESSION_TOKEN

    awset ${PROFILE}-mfa
}

function setregion {
    export AWS_REGION=$1
    export AWS_DEFAULT_REGION=$1
}

function ecrlogin {
    AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
    REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
    aws ecr  get-login-password  | docker login --username AWS --password-stdin $REGISTRY
}

function stree {
    region=$(aws s3api get-bucket-location --bucket $1 --output text --query 'LocationConstraint')
    if [ $region = "None" ]; then export region=us-east-1; fi
    echo "===== $1 ( $region ) ======"
    aws s3 ls --recursive s3://$1/ --region $region
}

function awsall {
    for profile in $(aws configure list-profiles)
    do
        echo "===== $profile ======"
        aws --profile $profile $@
    done
}
