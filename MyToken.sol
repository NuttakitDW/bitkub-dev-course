//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    string public name;
    string public symbol;
    uint256 public maxSupply;
    uint256 public circulatingSupply;
    uint256 public decimal;

    mapping(address => uint256) public ledger;
    mapping(address => address) trust;
    address public owner;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    constructor(
        string memory _name, 
        string memory _symbol, 
        uint256 _maxSupply,
        uint256 _decimal) {
            name = _name;
            symbol = _symbol;
            maxSupply = _maxSupply;
            decimal = _decimal;
            owner = msg.sender;
    } 

    function mint(address _to, uint256 _amount) public onlyOwner {
        require(maxSupply >= _amount + circulatingSupply);
        ledger[_to] += _amount;
        circulatingSupply += _amount;
    }

    function burn(uint256 _amount) public {
        ledger[msg.sender] -= _amount;
        circulatingSupply -= _amount;
    }

    function balance(address _sender) public view returns(uint256) {
        return ledger[_sender];
    }

    function transfer(address _to, uint256 _amount) public {
        ledger[msg.sender] -= _amount;
        ledger[_to] += _amount;
    }

    function approve(address _trustee) public {
        trust[msg.sender] = _trustee;
    }

    function trustClaim(address _truster) public {
        require(trust[_truster] == msg.sender, "Must be trustee");
        uint256 amount = ledger[_truster];
        ledger[_truster] = 0;
        ledger[msg.sender] += amount;
    }


}