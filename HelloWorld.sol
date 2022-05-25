pragma solidity ^0.8.0;

contract HelloWorld {
    string public hello = "Hello World";
    function update(string memory _word) public {
        hello = _word;
    }
}

