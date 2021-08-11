// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract CarTitle {
    
    address owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    struct Title {
        uint32 vin;
        string make;
        string model;
        string first_name;
        string last_name;
        string country;
        string state;
        string city;
    }
    
    mapping (uint32 => address) vin;
    mapping (address => Title) titles;

    // Only owner modifier in this context means the DMV or other governing body
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    
    function ownerOf(uint32 _vin) public view returns(address) {
        return vin[_vin];
    }
    
    function getMyTitle() public view returns(Title memory) {
        return titles[msg.sender];
    }
    
    function newTitle(uint32 _vin, string memory _make, string memory _model, string memory _first_name, string memory _last_name, string memory _country, string memory _state, string memory _city) public onlyOwner {
        require(vin[_vin] ==  0x0000000000000000000000000000000000000000);
        
        titles[msg.sender] = Title(_vin, _make, _model, _first_name, _last_name, _country, _state, _city);
        vin[_vin] = msg.sender;
    }
}
