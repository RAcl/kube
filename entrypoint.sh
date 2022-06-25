#!/bin/bash

# Stop execute on error
set -e

# create workdirs
mkdir -p ~/{.aws,.kube}

# create AWS's config files
cat > ~/.aws/credentials << EOF_CRED
[default]
aws_accesss_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_accesss_key = ${AWS_SECRET_ACCESS_KEY}
EOF_CRED

cat > ~/.aws/config << EOF_CFG
[default]
region = ${AWS_DEFAULT_REGION}
output = ${AWS_DEFAULT_OUTPUT}
EOF_CFG

# create K8s' config file
echo "${KUBE_CONFIG}" | base64 -d > ~/.kube/config

# execute kubectl command
sh -c "kubectl $*"

# delete workdirs
rm -rf ~/.aws
rm -rf ~/.kube
