```sh {"terminalRows":"14"}
#! /bin/bash
export WORKSPACE=solarbx
echo $WORKSPACE
terraform workspace select $WORKSPACE || terraform workspace new $WORKSPACE
terraform apply -var-file="./vars/$WORKSPACE.tfvars"
unset WORKSPACE
```