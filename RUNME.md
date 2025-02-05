```sh
#! /bin/bash
export WORKSPACE=0
echo $WORKSPACE
terraform workspace select $WORKSPACE || terraform workspace new $WORKSPACE
terraform apply -var-file="./vars/$WORKSPACE.tfvars"
```