// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "./libs/Pausable.sol";

contract Waqf is Pausable {
    // Total waqf received
    uint256 public amount;

    // Mapping to track the number of coins received by the contract
    mapping(address => uint256) public received;

    // Event to track the number of coins received by the contract
    event Received(
        address indexed _wallet,
        uint256 indexed _amount,
        uint256 indexed _at
    );

    // Fall back function to receive coins into the contract
    receive() external payable whenNotPaused {
        // Track the coins received by the contract
        received[msg.sender] += msg.value;

        // Track the total waqf received
        amount += msg.value;

        // Transfer the coins to the zero address to burn them
        payable(0).transfer(msg.value);

        // Track the amount of coins received by the contract
        emit Received(msg.sender, msg.value, block.timestamp);
    }
}
