alias gcplogin="gcloud auth login; gcloud auth application-default login"
ssh-add ~/.ssh/google_compute_engine
alias gtree="gcloud storage ls -l --recursive"

function gcpset {
    export CLOUDSDK_CORE_PROJECT=$1
}
