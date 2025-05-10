// SPDX-License-Identifer: MIT
pragma solidity ^0.8.0;
// Ether payments
// Modifiers
// Visibility
// Events
// Enums

contract HotelRoom {
    enum Statuses {
        Vacant,
        Occupied
    }
    Statuses public currentStatus; 

    event Occupy(address occupant, uint amount);
    address payable public owner;
    
    constructor() {
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant {
        require(currentStatus != Statuses.Occupied, "Currently occupied. Try again after they vacate.");
        _;
    }
    modifier onlyWhenSufficientFunds(uint amount) {
        require(msg.value >= amount ether, "You're supposed to pay at least 2 ether.");
        _;
    }

    function book() public payable onlyWhileVacant onlyWhenSufficientFunds(2 ether) {
        (bool status, bytes memory data) = owner.call{value: msg.value}("");
        require(status);
        currentStatus = Statuses.Occupied;
        emit Occupy(msg.sender, msg.value);
    }
}