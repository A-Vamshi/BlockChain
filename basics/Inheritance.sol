// SPDX-License-Identifier: MIT
pragma solidtiy ^0.8.0;

// Inheritance
// Factories

contract Ownable {
    address owner;
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner(address user) {
        require(user == owner, "Only owner can access");
        _;
    }
}

contract SecretVault {
    string secret;
    constructor(string memory _secret) public {
        secret = _secret;
    }

    function getSecret() public view returns(string) {
        return secret;
    }
}

contract Inheritance is Ownable {
    address secretVault;

    constructor(string memory secret) {
        SecretVault newSecret = new SecretVault(secret);
        secretVault = address(newSecret);
        super();
    }
    function getSecret() public view onlyOwner(msg.sender) returns(string) {
        return SecretValut(secretValut).getSecret();
    }
}