// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LoopsAndConditionals {
    // Conditionals 
    // Loops
    uint[] public array = [1, 2, 3, 4, 5, 6, 7];
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function isOwner() public view returns(bool) {
        return (msg.sender == owner);
    }
    
    function countEvens() public view returns(uint) {
        uint count = 0;
        for (uint i = 0; i < array.length; i++) {
            if (isEvenNumber(array[i])) {
                count++;
            }
        }
        return count;
    }

    function isEvenNumber(uint number) public view returns(bool) {
        if (number % 2 == 0) {
            return true;
        } else {
            return false;
        }
    }
}