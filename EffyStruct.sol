//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EffyStruct {
    struct Bitkuber {
        string name;
        uint256 id;
        bool active;
    }

    Bitkuber effy = Bitkuber("Nuttakit", 222, true);
    Bitkuber tent = Bitkuber("Tent", 18, true);

    function effyStatus() public view returns(bool) {
        return effy.active;
    }

    function fireEffy() public {
        effy.active = false;
    }

}