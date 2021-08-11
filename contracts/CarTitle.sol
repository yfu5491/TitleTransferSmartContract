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
    
    mapping (uint32 => address) vinToOwner; // Owner of vin
    mapping (address => Title[]) titles;
    
    mapping (address => uint256) balance; // For balanceOf()

    // Only owner modifier in this context means the DMV or other governing body
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    function transferFrom(address _from, address _to, uint32 _vin) public {
        require(vinToOwner[_vin] == msg.sender);
        
        vinToOwner[_vin] = _to;
        
        balance[msg.sender]--;
        balance[_to]++;
        
        for(uint i = 0; i < titles[msg.sender].length; i++) {
            if(titles[msg.sender][i].vin == _vin) { // If the VIN matches the one passed in this function
                titles[_to].push(titles[msg.sender][i]); // Send the title to the new account
                delete titles[msg.sender][i];
            }
        }
    }
    
    function ownerOf(uint32 _vin) public view returns(address) {
        return vinToOwner[_vin];
    }
    
    function balanceOf(address _owner) public view returns (uint256) {
        return balance[_owner];
    }
    
    function getMyTitles() public view returns(Title[] memory) {
        return titles[msg.sender];
    }
    
    function newTitle(address _owner, uint32 _vin, string memory _make, string memory _model, string memory _first_name, string memory _last_name, string memory _country, string memory _state, string memory _city) public onlyOwner {
        require(vinToOwner[_vin] ==  0x0000000000000000000000000000000000000000);
        
        titles[_owner].push(Title(_vin, _make, _model, _first_name, _last_name, _country, _state, _city));
        vinToOwner[_vin] = _owner;
        balance[_owner]++;
    }
}
