// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

import "./Data.sol";

contract NFTImplementations is Data{
    function getApproved(uint256 _vin) public view returns(address) {
        return approved[_vin];
    }
    
    function approve(address _approve, uint256 _vin) external {
        // This function is just here for ERC-721 standards.
        // In the context of a legal title, you only want the owner to have access to it.
        // emit Approval(msg.sender, msg.sender, _vin);
    }
    
    function transferFrom(address _to, uint256 _vin) public {
        require(vinToOwner[_vin] == msg.sender);
        
        vinToOwner[_vin] = _to;
        
        balance[msg.sender]--;
        balance[_to]++;
        
        for(uint i = 0; i < titles[msg.sender].length; i++) {
            if(titles[msg.sender][i].vin == _vin) { // If the VIN matches the one passed in this function
                titles[_to].push(titles[msg.sender][i]); // Send the title to the new account
                
                uint last = titles[msg.sender].length - 1;
                
                titles[msg.sender][i] = titles[msg.sender][last]; // Swap the values
                delete titles[msg.sender][last]; // Delete last value
                titles[msg.sender].pop();
            }
        }
        
    }
    
    function ownerOf(uint256 _vin) public view returns(address) {
        return vinToOwner[_vin];
    }
    
    function balanceOf(address _owner) public view returns (uint256) {
        return balance[_owner];
    }
}