#!/bin/sh

set -e

echo
echo "###################################################################"
echo "############         Generate crypto material          ############"
echo "###################################################################"

PROJPATH=$(pwd)
CLIPATH=$PROJPATH/cli/peers
ORDERERS=$CLIPATH/ordererOrgs
PEERS=$CLIPATH/peerOrgs

rm -Rf $CLIPATH
$PROJPATH/cryptogen generate --config=$PROJPATH/configs/crypto-config.yaml  --output=$CLIPATH

sh generate-cfgtx.sh