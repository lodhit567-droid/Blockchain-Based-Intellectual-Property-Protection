// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IPProtection {

    // Struct to store intellectual property details
    struct IntellectualProperty {
        uint id;
        string name;
        address owner;
        uint timestamp;
    }

    // Mapping to store intellectual property by ID
    mapping(uint => IntellectualProperty) public ipRegistry;

    // Event to log IP registration
    event IPRegistered(uint indexed id, string name, address indexed owner, uint timestamp);

    // Variable to keep track of the next IP ID
    uint public nextIPId = 1;

    // Function to register intellectual property
    function registerIP(string memory _name) public returns (uint) {
        uint ipId = nextIPId;
        ipRegistry[ipId] = IntellectualProperty(ipId, _name, msg.sender, block.timestamp);

        emit IPRegistered(ipId, _name, msg.sender, block.timestamp);

        nextIPId++;

        return ipId;
    }

    // Function to check ownership of intellectual property
    function checkOwnership(uint _id) public view returns (address) {
        require(_id < nextIPId, "IP ID does not exist.");
        return ipRegistry[_id].owner;
    }

    // Function to transfer ownership of intellectual property
    function transferOwnership(uint _id, address _newOwner) public {
        require(_id < nextIPId, "IP ID does not exist.");
        require(ipRegistry[_id].owner == msg.sender, "Only the current owner can transfer ownership.");
        
        ipRegistry[_id].owner = _newOwner;
    }
}
