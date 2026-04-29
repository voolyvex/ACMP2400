#!/bin/bash

set -e

export ARM_CLIENT_ID=${ARM_CLIENT_ID}
export ARM_CLIENT_SECRET=${INPUT_ARM_CLIENT_SECRET}
export ARM_SUBSCRIPTION_ID=${INPUT_ARM_SUBSCRIPTION_ID}
export ARM_TENANT_ID=${INPUT_ARM_TENANT_ID}
export DEV_STATE_KEY=${INPUT_DEV_STATE_KEY}
export TF_STAGE=${INPUT_TF_STAGE}
export DJANGO_SECRET_KEY=${INPUT_DJANGO_SECRET_KEY}

if [[ "$TF_STAGE" == "stage1   " ]]; then
    terraform -chdir=${INPUT_TF_STAGE} init -backend-config="key=${INPUT_STATE_KEY}.tfstate"
    terraform -chdir=${INPUT_TF_STAGE} plan -out=${INPUT_TF_STAGE}.tfplan
    terraform -chdir=${INPUT_TF_STAGE} apply -auto-approve ${INPUT_TF_STAGE}.tfplan
elif [[ "$TF_STAGE" == "stage2   " ]]; then
    terraform -chdir=${INPUT_TF_STAGE} init -backend-config="key=${INPUT_STATE_KEY}.tfstate"
    terraform -chdir=${INPUT_TF_STAGE} apply -auto-approve -var="ARM_CLIENT_ID=${INPUT_ARM_CLIENT_ID}" -var="DJANGO_SECRET_KEY_PROD=${INPUT_DJANGO_SECRET_KEY_PROD}"
elif [[ "$TF_STAGE" == "stage3   " ]]; then
    terraform -chdir=${INPUT_TF_STAGE} init -backend-config="key=${INPUT_STATE_KEY}.tfstate"
    terraform -chdir=${INPUT_TF_STAGE} plan -out=${INPUT_TF_STAGE}.tfplan
    terraform -chdir=${INPUT_TF_STAGE} apply -auto-approve ${INPUT_TF_STAGE}.tfplan
else
    echo "Invalid TF_STAGE value: $TF_STAGE"
    exit 1
fi