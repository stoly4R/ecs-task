#!/bin/bash
while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "options:"
      echo "-h, --help                show brief help"
      echo "--deploy,                 will run terraform apply and create environment based on your code"
      echo "--remove,                 will run terraform destroy and remove created environment"
      exit 0
      ;;
    --deploy)
      shift
      if test -f "terraform"; then
      echo "terraform binary exists"
      ./terraform init
      ./terraform apply -auto-approve
      else
      tar -zxvf terraform_0.13.0_linux_amd64.tar.gz
      ./terraform init
      ./terraform apply -auto-approve
      fi
      shift
      ;;
    --remove)
      shift
      ./terraform destroy -auto-approve
      shift
      ;;
    *)
      break
      ;;
  esac
done
