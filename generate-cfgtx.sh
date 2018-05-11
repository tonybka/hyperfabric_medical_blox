#!/bin/sh
CHANEL_NAME="default"
PROJPATH=$(pwd)
CLIPATH=$PROJPATH/cli/peers


echo
echo "###################################################################"
echo "############    Generateting orderer genesis blocks    ############"
echo "###################################################################"
$PROJPATH/configtxgen -profile ThreeOrgsGenesis -outputBlock $CLIPATH/genesis.block


echo
echo "#################################################################"
echo "### Generating channel configuration transaction 'channel.tx' ###"
echo "#################################################################"
$PROJPATH/configtxgen -profile ThreeOrgsChannel -outputCreateChannelTx $CLIPATH/channel.tx -channelID $CHANNEL_NAME
cp $CLIPATH/channel.tx $PROJPATH/web

echo
echo "#################################################################"
echo "####### Generating anchor peer update for MedicalCenterOrg ######"
echo "#################################################################"
$PROJPATH/configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate $CLIPATH/MedicalCenterOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg MedicalCenterOrgMSP

echo
echo "#################################################################"
echo "#######    Generating anchor peer update for InsuranceOrg   #####"
echo "#################################################################"
$PROJPATH/configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate $CLIPATH/InsuranceOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg InsuranceOrgMSP

echo
echo "#################################################################"
echo "#######    Generating anchor peer update for PharmacyOrg   ######"
echo "#################################################################"
$PROJPATH/configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate $CLIPATH/PharmacyOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg PharmacyOrgMSP