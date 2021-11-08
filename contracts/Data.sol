// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

contract Data {
    struct Title {
        uint256 vin;
        string make;
        string model;
        string first_name;
        string last_name;
        string country;
        string state;
        string city;
    }
    
    mapping (uint256 => address) vinToOwner; // Owner of vin
    mapping (address => Title[]) titles;
    
    mapping (address => uint256) balance; // For balanceOf()
    mapping (string => address) approved;
}