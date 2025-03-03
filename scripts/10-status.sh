#!/bin/bash
export VAULT_ADDR=$(terraform output -raw -state=./terraform/terraform.tfstate vault_url)
#export VAULT_SKIP_VERIFY=1
export VAULT_TOKEN=$(cat vault-init.json | jq -r '.root_token')
vault status
vault operator raft list-peers
echo
echo URL: $VAULT_ADDR
echo
echo Root Token:  $VAULT_TOKEN
