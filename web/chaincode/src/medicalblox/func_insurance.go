package main

import (
	"github.com/hyperledger/fabric/core/chaincode/shim"
	pb "github.com/hyperledger/fabric/protos/peer"
)

func queryUserProfile(stub shim.ChaincodeStubInterface, args []string) pb.Response {

	return shim.Success(nil)
}

func userAuthenticate(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	return shim.Success(nil)
}

func claimProcess(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	return shim.Success(nil)
}

func listClaims(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	return shim.Success(nil)
}

func fileClaim(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	return shim.Success(nil)
}
