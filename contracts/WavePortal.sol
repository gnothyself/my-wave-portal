// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint totalHighFives;

    uint256 private seed;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address actor;
        string message;
        uint256 timestamp;
    }

    Wave[] actions;

    mapping(address => uint256) public lastWavedAt;
    
    constructor() payable {
        console.log("We have been constructed!");

        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        require(
            lastWavedAt[msg.sender] + 23 hours < block.timestamp,
            "Wait 1 day"
        );

        lastWavedAt[msg.sender] = block.timestamp;
        
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);

        actions.push(Wave(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %d", seed);

        emit NewWave(msg.sender, block.timestamp, _message);

        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }
    }

    function highFive(string memory _message) public {
        require(
            lastWavedAt[msg.sender] + 23 hours < block.timestamp,
            "Wait 1 day"
        );

        lastWavedAt[msg.sender] = block.timestamp;

        totalHighFives += 1;
        console.log("%s has high fived", msg.sender);

        actions.push(Wave(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %d", seed);

        emit NewWave(msg.sender, block.timestamp, _message);

        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }
    }

    function getAllActions() public view returns (Wave[] memory) {
        return actions;
    }

    function getActionTotal() public view returns (uint256) {
        return totalWaves;
    }
}