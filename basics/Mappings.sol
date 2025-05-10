// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Mappings  -> Here we're reffering to hashmaps or dictionaries
contract Mappings {
    // Mapping syntax ->
    // write mapping(key => value) mapName; 
    // here key values are data types for example uint or string etc.
    mapping(uint => string) public names;
    mapping(uint => Book) public books;
    mapping(address => mapping(uint => Book)) public myBooks;
    constructor() {
        names[0] = "Cale";
    }


    struct Book {
        string name;
        string author;
    }

    function addBook(uint id, string memory name, string memory author) public {
        books[id] = Book(name, author);
    }

    function addMyBook(uint id, string memory name, string memory author) public {
        myBooks[msg.sender][id] = Book(name, author);
    }

}