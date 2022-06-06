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
    mapping(address => uint256) public ledger;

    mapping(string => uint256) public milesOfCar;
    mapping(string => uint256) public speedOfCar;
    mapping(string => bool) public isCar;
    mapping(address => bool) internal vip;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    modifier onlyVIP {
        require(vip[msg.sender] == true);
        _;
    }

    constructor(uint256 _balance, address _wallet) {

        owner = msg.sender;
        wallet = _wallet;
        ledger[_wallet] = _balance;
        balance = ledger[_wallet];
    }

    function tinder(string memory _girl) public {
        girl.push(_girl);
    }

    //onlyOwner can see it????
    function getWallet() public view onlyOwner returns(address) {
        return wallet;
    }

    function addCar(string memory _car, uint256 _miles, uint256 _speed) public {
        require(isCar[_car] == false, "Tony already has this car");
        milesOfCar[_car] = _miles;
        speedOfCar[_car] = _speed;
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


    function showName(bool _i) public pure returns(string memory) {
        if (_i == true) {
            return "Welcome";
        }

        else {
            return "Get Out";
        }
    }

    function transfer(address _to, uint256 _amount) public returns(uint256) {
        //Tony transfer money to somebody

        //Condition 
        // 1. have 2 parameters that are _amount and _to
        // 2. return curent balance of Tony
        // 3. use require _amount < balance [optional]
        require(_amount < balance);
        ledger[wallet] -= _amount;
        ledger[_to] += _amount;
        balance = ledger[wallet];
        return balance;
    }

    function fasterCar(string memory _car1, string memory _car2) public view returns(string memory) {
        // Get 2 car and return which one is faster
        // 1. must have 2 parameters that are car1 and car2
        // 2. HINT: Use mapping
        // 3. HINT: if else and > <

        if(speedOfCar[_car1] > speedOfCar[_car2]) {
            return _car1;
        }
        else if (speedOfCar[_car1] == speedOfCar[_car2]) {
            return "This two car have a same speed";
        }
        else {
            return _car2;
        }
    }

    function addVIP(address _vip) public onlyOwner {
        vip[_vip] = true;
    }

    function isVIP() public view onlyVIP returns(string memory) {
        // 1. use modifier
        // 2. return string "This one is VIP"
        // 3. use 2nd mock address
        return "This one is VIP";

    }

}