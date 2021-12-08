// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint totalHighFives;

    constructor() {
        console.log("Hello everyone and welcome to another episode of The Daily Gwei Refuel");
    }

    function wave() public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);
    }

    function highFive() public {
        totalHighFives += 1;
        console.log("%s has high fived", msg.sender);
    }

    function getActionTotal() public view returns (uint256) {
        console.log("We have %d total waves and %d total high fives!", totalWaves, totalHighFives);
        return totalWaves;
    }
}