//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicSolidity {

    //Global Variable
    uint256 public global = 10;
    //Local Variable
    // local = i;

    //Iron Man Profile
    string public name = "Tony Stark";

    uint256 public age = 48;
    bool public isMale = true;

    uint256 public balance;
    string[] public career = ["Playboy", "Engineer", "Hero"];

    address wallet;

    string[] public girl;

    address public owner;

    mapping(string => uint256) public milesOfCar;
    mapping(string => bool) public isCar;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    constructor(uint256 _balance, address _wallet) {

        owner = msg.sender;
        balance = _balance;
        wallet = _wallet;
    }

    function tinder(string memory _girl) public {
        girl.push(_girl);
    }

    //onlyOwner can see it????
    function getWallet() public view onlyOwner returns(address) {
        return wallet;
    }

    function addCar(string memory _car, uint256 _miles) public {
        require(isCar[_car] == false, "Tony already has this car");
        milesOfCar[_car] = _miles;
        isCar[_car] = true;
    }

    // Show what difference between Local variable & Global
    function getNumber(uint256 _i) public view returns(uint256) {
        uint256 local = _i;
        uint256 result = global + local;
        return result;
    }

    function plusResult() public view returns(uint256) {
        return global + 1;
    }


    function showName(bool _i) public view returns(string memory) {
        if (_i == true) {
            return "Welcome";
        }

        else {
            return "Get Out";
        }
    }

    function transfer() public view return(uint256) {
        //Tony transfer money to somebody

        //Condition 
        // 1. have 2 parameters that are _amount and _to
        // 2. return curent balance of Tony
        // 3. use require _amount < balance [optional]
    }

    function fasterCar() {
        // Get 2 car and return which one is faster
        // 1. must have 2 parameters that are car1 and car2
        // 2. HINT: Use mapping
        // 3. HINT: if else and > <
    }

    function isVIP() {
        // 1. use modifier
        // 2. return string "This one is VIP"
        // 3. use 2nd mock address
    }



}