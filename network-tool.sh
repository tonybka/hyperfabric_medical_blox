#!/bin/bash

export PATH=${PWD}/binary/fabric_tools_mac:$PATH
export FABRIC_CFG_PATH=${PWD}

# Print the usage message
function printHelp () {
  echo "Usage: "
  echo "  network-tool.sh up|down|restart|generate|upgrade [-c <channel name>] [-t <timeout>] [-d <delay>] [-f <docker-compose-file>] [-s <dbtype>] [-i <imagetag>]"
  echo "  network-tool.sh -h|--help (print this message)"
  echo "    <mode> - one of 'up', 'down', 'restart' or 'generate'"
  echo "      - 'up' - bring up the network with docker-compose up"
  echo "      - 'down' - clear the network with docker-compose down"
  echo "      - 'restart' - restart the network"
  echo "      - 'generate' - generate required certificates and genesis block"
  echo "      - 'upgrade'  - upgrade the network from v1.0.x to v1.1"
  echo "    -c <channel name> - channel name to use (defaults to \"mychannel\")"
  echo "    -t <timeout> - CLI timeout duration in seconds (defaults to 10)"
  echo "    -d <delay> - delay duration in seconds (defaults to 3)"
  echo "    -f <docker-compose-file> - specify which docker-compose file use (defaults to docker-compose-cli.yaml)"
  echo "    -s <dbtype> - the database backend to use: goleveldb (default) or couchdb"
  echo "    -l <language> - the chaincode language: golang (default) or node"
  echo "    -i <imagetag> - the tag to be used to launch the network (defaults to \"latest\")"
  echo
  echo "Typically, one would first generate the required certificates and "
  echo "genesis block, then bring up the network. e.g.:"
  echo
  echo "	network-tool.sh generate -c mychannel"
  echo "	network-tool.sh up -c mychannel -s couchdb"
  echo "        network-tool.sh up -c mychannel -s couchdb -i 1.1.0-alpha"
  echo "	network-tool.sh up -l node"
  echo "	network-tool.sh down -c mychannel"
  echo "        network-tool.sh upgrade -c mychannel"
  echo
  echo "Taking all defaults:"
  echo "	network-tool.sh generate"
  echo "	network-tool.sh up"
  echo "	network-tool.sh down"
}


MODE=$1;shift
# Determine whether starting, stopping, restarting or generating for announce
if [ "$MODE" == "up" ]; then
  EXPMODE="Starting"
elif [ "$MODE" == "down" ]; then
  EXPMODE="Stopping"
elif [ "$MODE" == "restart" ]; then
  EXPMODE="Restarting"
elif [ "$MODE" == "generate" ]; then
  EXPMODE="Generating certs and genesis block for"
elif [ "$MODE" == "upgrade" ]; then
  EXPMODE="Upgrading the network"
else
  printHelp
  exit 1
fi