// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract Counter {
    // code goes here
    uint count; 
            // You can declare this as :
            //                          uint public count;
            //                          This creates a getter automatically
            // You can declare this as :
            //                          uint public count = 0;
            //                          This allows you to avoid using a constructor 


    // This is called a state variables (They are stored in the blockchain and are declared in the contract not functions)
    // Constructor for the smart contract
    constructor() {
        count = 0;
    }

    // Creating a function syntax for getter
    function getCount() public view returns(uint) {
        // This is a read function and they are free in the blockchain
        return count;
    }
    // Setter function
    function incrementCount() public {
        // This is a write function and requires you to pay gas 
        count++;
    }
}