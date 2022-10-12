pragma solidity ^0.8.0;

contract Student {

    string public name;
    uint public studentId;
    bool public isGraduate;
    address public owner;
    string[] public grades;
    mapping(string=>uint) public subjectToGrade;
    uint public point;

    function setName(string memory _name) public {
        string memory _name2;
        _name2 = _name;
        name = _name;
        _increasePoint();
    }

    function addGrade(string memory _grade) public {
        grades.push(_grade);
        _increasePoint();
    }

    function showGrade() public view returns(string[] memory) {
        return grades;
    }

    function giveGrade(string memory _subject, uint _grade) public {
        subjectToGrade[_subject] = _grade;
        _increasePoint();
    }

    function _increasePoint() internal {
        point++;
    }

    function deleteSubject(string memory _subject) public {
        delete subjectToGrade[_subject];
    }

}

contract Lock {
    bool public isLock = false;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function unlock() public onlyOwner {
        isLock = true;
    }

    function lock() public onlyOwner {
        isLock = false;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "You are not allowed.");
        _;
    }

    function isEven(uint _num) public view returns(bool) {
        if(_num%2==0) {
            return true;
        }
        else {
            return false;
        }
    }
}

contract Criminal {
    mapping(string=>bool) public criminalList;
    string[] public names;
    constructor(string[] memory _names, bool[] memory _isCrime) {
        require(_names.length == _isCrime.length);
        names = _names;
        for(uint i=0; i < _names.length; i++) {
            criminalList[_names[i]] = _isCrime[i];
        }
    }

    function findCrime() public view returns(string memory) {
        for(uint i=0; i < names.length; i++) {
            if(criminalList[names[i]] == true) {
                return names[i];
            }
        }
    }
}
