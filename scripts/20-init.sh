#!/bin/bash
set -o pipefail

export VAULT_ADDR=$(terraform output -raw -state=./terraform/terraform.tfstate vault_url)
#export VAULT_SKIP_VERIFY=1
vault status

vault operator init --recovery-shares=1 -recovery-threshold=1 -format=json | tee vault-init.json
echo Waiting for initialisation...
sleep 30
export VAULT_TOKEN=$(cat vault-init.json | jq -r '.root_token')
vault audit enable file file_path=/var/log/vault/audit.log
vault status
vault operator raft list-peers

sed -i "" "s#VAULT_ADDR=.*#VAULT_ADDR=${VAULT_ADDR}#g" .env
sed -i "" "s/VAULT_TOKEN=.*/VAULT_TOKEN=${VAULT_TOKEN}/g" .env
