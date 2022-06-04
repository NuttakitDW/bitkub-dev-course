//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    string public name;
    string public symbol;
    uint256 public maxSupply;
    uint256 public circulatingSupply;
    uint256 public decimal;

    constructor(
        string memory _name, 
        string memory _symbol, 
        uint256 _maxSupply,
        uint256 _decimal) {
            name = _name;
            symbol = _symbol;
            maxSupply = _maxSupply;
            decimal = _decimal;
    } 
}