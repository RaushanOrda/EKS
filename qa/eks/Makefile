.PHONY: default
default: apply
init:
	rm -rf .terraform
	terraform fmt
ifeq ($(color),true)
	TC=""
else
	TC=" -no-color"
endif
	terraform init $(TC)
plan: init
	terraform plan $(TC) -out plan.out -detailed-exitcode ; echo $$? > status.out
destroy:
	terraform destroy $(TC)
apply: 
	terraform apply $(TC) plan.out
	@rm -rf *.out
auto-apply: init plan
	terraform apply $(TC) plan.out --auto-approve
