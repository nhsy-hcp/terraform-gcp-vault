set -o pipefail -e

export VAULT_ADDR=$(terraform output -raw vault_url)
export VAULT_SKIP_VERIFY=1
vault operator init --recovery-shares=1 -recovery-threshold=1 -format=json | tee vault-init.json

export VAULT_TOKEN=$(cat vault-init.json | jq -r '.root_token')
vault status
vault operator raft list-peers

vault audit enable file file_path=/var/log/vault/audit.log
