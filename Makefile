.PHONY: all init apply plan output destroy fmt clean

all: apply

fmt:
	@terraform fmt -recursive

init: fmt
	@terraform init

apply: init
	@terraform validate
	@terraform apply -auto-approve \
 		-target module.network.module.vpc
	@terraform apply -auto-approve

plan: init
	@terraform validate
	@terraform plan

output:
	@terraform output

destroy: init
	@terraform destroy -auto-approve
#	-@rm routes.tf

clean:
	-rm -rf .terraform/
	-rm .terraform.lock.hcl
	-rm terraform.tfstate*
