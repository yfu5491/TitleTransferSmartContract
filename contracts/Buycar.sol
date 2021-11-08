// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

contract Buycar {
address[16] public buyers;
    // Adopting a pet
    function buy(uint carId) public returns (uint) {
    require(carId >= 0);

    buyers[carId] = msg.sender;

    return carId;
    }
    
    // Retrieving the adopters
    function getBuyers() public view returns (address[16] memory) {
    return buyers;
    }
}
