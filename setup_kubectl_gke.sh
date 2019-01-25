#!/usr/bin/env bash
set -euo pipefail

##
## This script creates a config file for accessing an gke cluster
## with kubectl. It uses gcloud cli to retrieve the needed information
##

CLUSTER_NAME="gke-test"
KUBECONFIG="${HOME}/.kube/config-${CLUSTER_NAME}"

# make sure kubectl config dir exists
mkdir -p "$(dirname "${KUBECONFIG}")"
[ -f "${KUBECONFIG}" ] && rm "${KUBECONFIG}"

# call gloud get-credentials
gcloud container clusters get-credentials "${CLUSTER_NAME}"

echo
echo "You can use the created kubeconfig with"
echo "export KUBECONFIG=\"${KUBECONFIG}\""
echo
