package main

import (
	"github.com/hyperledger/fabric/core/chaincode/shim"
	pb "github.com/hyperledger/fabric/protos/peer"
)

var logger = shim.NewLogger("main")

type SmartContract struct {
}

var blockchainFunctions = map[string]func(shim.ChaincodeStubInterface, []string) pb.Response{}

// Init callback representing the invocation of a chaincode
func (t *SmartContract) Init(stub shim.ChaincodeStubInterface) pb.Response {

	return shim.Success(nil)
}

// Invoke Function accept blockchain code invocations.
func (t *SmartContract) Invoke(stub shim.ChaincodeStubInterface) pb.Response {
	function, args := stub.GetFunctionAndParameters()

	if function == "init" {
		return t.Init(stub)
	}
	bcFunc := blockchainFunctions[function]
	if bcFunc == nil {
		return shim.Error("Invalid invoke function.")
	}

	return bcFunc(stub, args)
}

func main() {}
