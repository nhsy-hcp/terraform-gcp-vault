#!/bin/bash
set -o pipefail -e
exec >> /var/log/bootstrap.log 2>&1

if [[ -d /opt/ansible ]]; then
    echo "vault already installed"
    echo "metadata_startup skipped"
    exit 0
fi

cd /tmp
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
bash add-google-cloud-ops-agent-repo.sh --also-install

export DEBIAN_FRONTEND=noninteractive
apt update
apt-get upgrade --yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"
apt-get install --yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" software-properties-common
add-apt-repository --yes --update ppa:ansible/ansible
apt-get install --yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" ansible git jq htop
apt-get autoremove -y

tee /etc/google-cloud-ops-agent/config.yaml > /dev/null << EOF
metrics:
  receivers:
    vault:
      type: vault
      endpoint: 127.0.0.1:8200
      insecure_skip_verify: true
      insecure: false
      collection_interval: 30s
  service:
    pipelines:
      vault:
        receivers: [vault]

logging:
  receivers:
    vault_audit:
      type: vault_audit
      include_paths: [/var/log/vault/audit.log]
    vault_syslog:
      type: files
      include_paths: [/var/log/vault.log]
  service:
    pipelines:
      vault_audit:
        receivers: [vault_audit]
      vault_syslog:
        receivers: [vault_syslog]
EOF

systemctl restart google-cloud-ops-agent

mkdir -p /opt/ansible
cd /opt/ansible
gsutil -m cp -r gs://${ansible_bucket_name}/* .

cat <<EOF > group_vars/vault.yml
---
cloud:
  provider: 'gce'
  gce_tag: 'vault-node'

enterprise: true
vault_license_string: '${vault_license}'
vault_storage_backend: 'integrated'
vault_tls_ca_cert_file: 'tls/ca.pem'
vault_tls_cert_file: 'tls/vault.pem'
vault_tls_key_file: 'tls/vault.key'
vault_version: '${vault_version}'

vault_seal:
  type: gcpckms
  project: ${project_id}
  region: ${kms_location}
  key_ring: ${key_ring}
  crypto_key: ${crypto_key}

vault_unauthenticated_metrics_access: true
vault_telemetry:
  prometheus_retention_time: '10m'
  disable_hostname: false
  stackdriver_project_id: ${project_id}
  stackdriver_location: ${region}
  stackdriver_namespace: ${namespace}
  disable_hostname: true
  enable_hostname_label: true
EOF

ansible-playbook vault-playbook.yml
sleep 30
export VAULT_SKIP_VERIFY=1
vault status

echo "metadata_startup completed"