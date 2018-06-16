package main

import (
	"encoding/json"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	pb "github.com/hyperledger/fabric/protos/peer"
)

/**
Create new user profile: Normal user or Patient
**/
func createUserProfile(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	if len(args) != 1 {
		return shim.Error("Invalid argument count.")
	}

	user := user{}
	// Decode JSON-encoded object and save into "user"
	err := json.Unmarshal([]byte(args[0]), &user)
	if err != nil {
		return shim.Error(err.Error())
	}

	// Create composite key with user name
	key, err := stub.CreateCompositeKey(prefixUser, []string{user.UserName})
	if err != nil {
		return shim.Error(err.Error())
	}

	// Check if the user already exists
	userAsBytes, _ := stub.GetState(key)

	// User does not exist, attempting creation
	if len(userAsBytes) == 0 {
		userAsBytes, err = json.Marshal(user)
		if err != nil {
			return shim.Error(err.Error())
		}
		//  Save index entry to state. Only the key name is needed, no need to store a duplicate copy of the user.
		//  Note - passing a 'nil' value will effectively delete the key from state
		err = stub.PutState(key, userAsBytes)
		if err != nil {
			return shim.Error(err.Error())
		}

		// Return nil, if user is newly created
		return shim.Success(nil)
	}

	// Decode existing user object
	err = json.Unmarshal(userAsBytes, &user)
	if err != nil {
		return shim.Error(err.Error())
	}

	userInfoResponse := struct {
		UserName string `json:"username"`
		Password string `json:"password"`
	}{
		UserName: user.UserName,
		Password: user.Password,
	}

	userInfoResponseAsBytes, err := json.Marshal(userInfoResponse)

	if err != nil {
		return shim.Error(err.Error())
	}

	// Return user information with UserName and Password of existing user
	return shim.Success(userInfoResponseAsBytes)
}

func updateUserProfile(stub shim.ChaincodeStubInterface, args []string) pb.Response {

	return shim.Success(nil)

}
