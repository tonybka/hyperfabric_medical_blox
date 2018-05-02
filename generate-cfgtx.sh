#!/bin/sh
CHANEL_NAME="default"
PROJPATH=$(pwd)
CLIPATH = $PROJPATH/cli/peers


echo
echo "###################################################################"
echo "############    Generateting orderer genesis blocks    ############"
echo "###################################################################"
$PROJPATH/configtxgen -profile ThreeOrgsGenesis -outputBlock $CLIPATH/genesis.block