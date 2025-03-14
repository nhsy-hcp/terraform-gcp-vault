export VAULT_ADDR=$(terraform output -raw vault_url)
export VAULT_SKIP_VERIFY=1
export VAULT_TOKEN=$(cat vault-init.json | jq -r '.root_token')

echo VAULT_TOKEN: $VAULT_TOKEN
