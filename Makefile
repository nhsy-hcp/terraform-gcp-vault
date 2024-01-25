.PHONY: all init apply plan output destroy fmt clean benchmark

VAULT_ADDR ?= $(shell terraform output -raw vault_url)

all: apply

fmt:
	@terraform fmt -recursive

init: fmt
	@terraform init

apply: init
	@terraform validate
	@terraform apply -auto-approve

plan: init
	@terraform validate
	@terraform plan

output:
	@terraform output

destroy: init
	@terraform destroy -auto-approve
#	-@rm routes.tf

mig-replace: init
	@terraform destroy -auto-approve -target module.vault.module.mig.google_compute_region_instance_group_manager.mig
	@terraform apply -auto-approve

mig-destroy: init
	@terraform destroy -auto-approve -target module.vault.module.mig.google_compute_region_instance_group_manager.mig

curl:
	@while true;do curl -skv $(VAULT_ADDR)/v1/sys/health;sleep 3;done

raft:
	@while true;do vault operator raft list-peers;sleep 3;done

benchmark:
	@vault-benchmark run -config=tests/benchmark/config.hcl

clean:
	-rm -rf .terraform/
	-rm .terraform.lock.hcl
	-rm terraform.tfstate*
