package main

import (
	"github.com/hyperledger/fabric/core/chaincode/shim"
	pb "github.com/hyperledger/fabric/protos/peer"
)

// sell medicine to patient
func sellMedicineProcess(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	return shim.Success(nil)
}
