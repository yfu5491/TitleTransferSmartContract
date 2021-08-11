// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./NFTImplementations.sol";

contract CarTitle is NFTImplementations{
    
    address owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    

    // Only owner modifier in this context means the DMV or other governing body
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    
    function getMyTitles() public view returns(Title[] memory) {
        return titles[msg.sender];
    }
    
    function newTitle(address _owner, uint256 _vin, string memory _make, string memory _model, string memory _first_name, string memory _last_name, string memory _country, string memory _state, string memory _city) public onlyOwner {
        require(vinToOwner[_vin] ==  0x0000000000000000000000000000000000000000);
        
        titles[_owner].push(Title(_vin, _make, _model, _first_name, _last_name, _country, _state, _city));
        vinToOwner[_vin] = _owner;
        balance[_owner]++;
    }
}
