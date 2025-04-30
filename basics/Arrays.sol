// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Arrays {
    // Arrays
    uint[] public arr = [1, 2, 3, 4, 5];
    string[] public names = ["Cale", "Hajin", "Kim"];
    string[] public values;

    function addValue(string memory value) public {
        values.push(value);
    }

    function valuesLength() public view returns(uint) { 
        return values.length;
    }

}