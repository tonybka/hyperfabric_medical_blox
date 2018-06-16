package main

import (
	"fmt"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	pb "github.com/hyperledger/fabric/protos/peer"
)

var logger = shim.NewLogger("main")

type SmartContract struct {
}

/**
**/
var blockchainFunctions = map[string]func(shim.ChaincodeStubInterface, []string) pb.Response{
	// Medical center peer
	"create_user_profile": createUserProfile,
	"update_user_profile": updateUserProfile,

	// Insurance peer
	"claim_ls":           listClaims,
	"claim_file":         fileClaim,
	"claim_process":      claimProcess,
	"query_user_profile": queryUserProfile,
	"user_authenticate":  userAuthenticate,
	// Pharmacy peer
	"sell_medicine_process": sellMedicineProcess,
}

// Init callback representing the invocation of a chaincode
func (t *SmartContract) Init(stub shim.ChaincodeStubInterface) pb.Response {
	_, args := stub.GetFunctionAndParameters()
	if len(args) == 1 {

	}
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

func main() {
	logger.SetLevel(shim.LogInfo)
	err := shim.Start(new(SmartContract))
	if err != nil {
		fmt.Println("Error while starting chaincode: %s", err)
	}
}
