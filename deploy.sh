#!/bin/bash

ARCH="amd64"
TERRAFORM_VERSION="0.13.0"
OS="linux"

if test -f "terraform"; then
    echo "terraform binary exists"
    ./terraform init
else
    tar -zxvf 
fi
