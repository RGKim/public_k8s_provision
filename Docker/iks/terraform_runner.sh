#/bin/bash

cd iks

terraform init

terraform plan

terraform apply -auto-approve