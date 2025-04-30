// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Variables {
    // State Variables
    uint public value = 10;
    // uint is short for uint256 (the default used in solidity)
    int public value2 = -1;
    // int can be used for negative numbers
    
    // Strings
    string public str = "A string";
    // Bytes
    bytes32 public byteData = "Bytes data";

    // Address
    // address public anAddress = 0x_____________________________________Ff1;

    // Struct
    struct Structure {
        uint256 id;
        address toAddress;
        string name;
    }
    // Structure public stru1 = Structure(1, 0x_____________________________________Ff1 , "Binance Edited name");


    // Local Variables
    function getLocalValue() public pure returns(uint) {
        uint localValue = 10;
        return localValue;
    }

}