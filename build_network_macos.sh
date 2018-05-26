#!/bin/bash
cp ./binary/fabric_tools_mac/* .
export FABRIC_MEDICALBLOX_PATH=$PWD
source ~/.bash_profile
sh ./generate-certs.sh
sh ./docker-images.sh
docker-compose up -d