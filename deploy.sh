#!/bin/sh

set -e

echo "$KUBECTL_CA_CERT" > ca.pem
echo "$KUBECTL_CLIENT_CERT" > client.pem
echo "$KUBECTL_CLIENT_KEY" > client-key.pem

kubectl config set-cluster default \
  --server=$KUBECTL_API_SERVER \
  --certificate-authority=ca.pem

kubectl config set-credentials default \
  --client-certificate=client.pem \
  --client-key=client-key.pem

kubectl --cluster=default --user=default apply -f $PLUGIN_RESOURCE_FILE
