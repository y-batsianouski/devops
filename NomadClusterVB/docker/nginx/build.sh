#!/bin/bash
cd "$( dirname "${BASH_SOURCE[0]}" )"
docker build -t nginx-lb .
rm -rf ./outputs
mkdir -p ./outputs
docker save nginx-lb > ./outputs/nginx-lb.tar