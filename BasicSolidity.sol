pragma solidity ^0.8.0;

contract BasicSolidity1 {

    //string
    string public name = "Tony Stark";

    //Integer
    uint256 public age = 48;

    //Boolean
    bool public rich = true;

    //Address
    address public wallet = 0xdCD9D1429541f8A2926192956036a141d5825A35;

    //Array
    string[] public cars = ["BMW", "Tesla", "Ford", "Mercedes Benz"];
    uint256[] public miles = [10000, 4323, 9959, 123123];

    //Mapping
    mapping(string => uint256) public milesOfCar;

    //global variable
    uint256 public money;

    //constructor
    constructor(uint256 _money) {

        money = _money;

        milesOfCar["BMW"] = 10000;
        milesOfCar["Tesla"] = 4323;
        milesOfCar["Ford"] = 9959;
        milesOfCar["Mercedes"] = 123123;
        
    }
    
    //function
    function addCar(string memory _car, uint256 _miles) public {
        milesOfCar[_car] = _miles;
    }

    function updateName() public {
        //HomeWork: Set new name
    }

    function updateAge() public {
        //HomeWork: Set new age
    }

    function updateRich() public {
        //HomeWork: Set rich to false
    }

    function updateWallet() public {
        //HomeWork: Set Wallet Address to your own wallet
    }

}
