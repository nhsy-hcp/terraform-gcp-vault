.PHONY: all init apply plan output destroy fmt clean benchmark

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

benchmark:
	@vault-benchmark run -config=tests/benchmark/config.hcl

clean:
	-rm -rf .terraform/
	-rm .terraform.lock.hcl
	-rm terraform.tfstate*
