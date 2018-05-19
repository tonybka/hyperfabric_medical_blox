#!/bin/sh

set -e

echo
echo "###################################################################"
echo "############         Generate crypto material          ############"
echo "###################################################################"

PROJPATH=$(pwd)
CLIPATH=$PROJPATH/cli/peers
ORDERERS=$CLIPATH/ordererOrganizations
PEERS=$CLIPATH/peerOrganizations

rm -Rf $CLIPATH
$PROJPATH/cryptogen generate --config=$PROJPATH/crypto-config.yaml --output=$CLIPATH

sh generate-cfgtx.sh

rm -rf $PROJPATH/{orderer,medicalcenterPeer,insurancePeer,pharmacyPeer}/crypto
mkdir -p $PROJPATH/{orderer,medicalcenterPeer,insurancePeer,pharmacyPeer}/crypto

cp -r $ORDERERS/orderer-org/orderers/orderer0/{msp,tls} $PROJPATH/orderer/crypto
cp -r $PEERS/medicalcenter-org/peers/medicalcenter-peer/{msp,tls} $PROJPATH/medicalcenterPeer/crypto
cp -r $PEERS/insurance-org/peers/insurance-peer/{msp,tls} $PROJPATH/insurancePeer/crypto
cp -r $PEERS/pharmacy-org/peers/pharmacy-peer/{msp,tls} $PROJPATH/pharmacyPeer/crypto

cp $CLIPATH/genesis.block $PROJPATH/orderer/crypto/


MEDICAL_CENTRER_CAPATH=$PROJPATH/medicalcenterCA
INSURANCE_CAPATH=$PROJPATH/insuranceCA
PHARMACY_CAPATH=$PROJPATH/pharmacyCA

rm -rf {$MEDICAL_CENTRER_CAPATH,$INSURANCE_CAPATH,$PHARMACY_CAPATH}/{ca,tls}
mkdir -p {$MEDICAL_CENTRER_CAPATH,$INSURANCE_CAPATH,$PHARMACY_CAPATH}/{ca,tls}

cp $PEERS/medicalcenter-org/ca/* $MEDICAL_CENTRER_CAPATH/ca
cp $PEERS/medicalcenter-org/tlsca/* $MEDICAL_CENTRER_CAPATH/tls
mv $MEDICAL_CENTRER_CAPATH/ca/*_sk $MEDICAL_CENTRER_CAPATH/ca/key.pem
mv $MEDICAL_CENTRER_CAPATH/ca/*-cert.pem $MEDICAL_CENTRER_CAPATH/ca/cert.pem
mv $MEDICAL_CENTRER_CAPATH/tls/*_sk $MEDICAL_CENTRER_CAPATH/tls/key.pem
mv $MEDICAL_CENTRER_CAPATH/tls/*-cert.pem $MEDICAL_CENTRER_CAPATH/tls/cert.pem

cp $PEERS/insurance-org/ca/* $INSURANCE_CAPATH/ca
cp $PEERS/insurance-org/tlsca/* $INSURANCE_CAPATH/tls
mv $INSURANCE_CAPATH/ca/*_sk $INSURANCE_CAPATH/ca/key.pem
mv $INSURANCE_CAPATH/ca/*-cert.pem $INSURANCE_CAPATH/ca/cert.pem
mv $INSURANCE_CAPATH/tls/*_sk $INSURANCE_CAPATH/tls/key.pem
mv $INSURANCE_CAPATH/tls/*-cert.pem $INSURANCE_CAPATH/tls/cert.pem

cp $PEERS/pharmacy-org/ca/* $PHARMACY_CAPATH/ca
cp $PEERS/pharmacy-org/tlsca/* $PHARMACY_CAPATH/tls
mv $PHARMACY_CAPATH/ca/*_sk $PHARMACY_CAPATH/ca/key.pem
mv $PHARMACY_CAPATH/ca/*-cert.pem $PHARMACY_CAPATH/ca/cert.pem
mv $PHARMACY_CAPATH/tls/*_sk $PHARMACY_CAPATH/tls/key.pem
mv $PHARMACY_CAPATH/tls/*-cert.pem $PHARMACY_CAPATH/tls/cert.pem

WEBCERTS=$PROJPATH/web/certs
rm -rf $WEBCERTS
mkdir -p $WEBCERTS

cp $PROJPATH/orderer/crypto/tls/ca.crt $WEBCERTS/ordererOrg.pem
cp $PROJPATH/medicalcenterPeer/crypto/tls/ca.crt $WEBCERTS/medicalCenterOrg.pem
cp $PROJPATH/insurancePeer/crypto/tls/ca.crt $WEBCERTS/insuranceOrg.pem
cp $PROJPATH/pharmacyPeer/crypto/tls/ca.crt $WEBCERTS/pharmacyOrg.pem

cp $PEERS/medicalcenter-org/users/Admin@medicalcenter-org/msp/keystore/* $WEBCERTS/Admin@medicalcenter-org-key.pem
cp $PEERS/medicalcenter-org/users/Admin@medicalcenter-org/msp/signcerts/* $WEBCERTS/
cp $PEERS/insurance-org/users/Admin@insurance-org/msp/keystore/* $WEBCERTS/Admin@insurance-org-key.pem
cp $PEERS/insurance-org/users/Admin@insurance-org/msp/signcerts/* $WEBCERTS/
cp $PEERS/pharmacy-org/users/Admin@pharmacy-org/msp/keystore/* $WEBCERTS/Admin@pharmacy-org-key.pem
cp $PEERS/pharmacy-org/users/Admin@pharmacy-org/msp/signcerts/* $WEBCERTS/
