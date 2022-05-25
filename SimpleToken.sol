pragma solidity ^0.8.0;

contract SimpleToken {

    string public name;
    string public symbol;
    uint256 public totalSuply;

    mapping(address => uint256) public ledger;

    constructor(string memory _name, string memory _symbol) {

        name = _name;
        ticker = _ticker;
        totalSuply = 1000;

        ledger[msg.sender] = 1000;

    }

    function mint(address _to, uint256 _amount) public {
        totalSuply += _amount;
        ledger[_to] += _amount;
    }

    function burn(uint256 _amount) public {
        totalSuply -= _amount;
        ledger[msg.sender] -= _amount;
    }

    function transfer(address _to, uint256 _amount) public {
        ledger[msg.sender] -= _amount;
        ledger[_to] += _amount;
    }

}
